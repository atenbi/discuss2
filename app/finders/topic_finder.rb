class TopicFinder
  DEFAULT_SORT = "active_at desc".freeze
  PINNED_SQL   = "pinned_at IS NOT NULL DESC, pinned_at DESC".freeze

  class << self
    def perform(ransack_params:, params:)
      set_default_sort(ransack_params)

      ransack, query, user_sort_sql = apply_ransack_sorts(ransack_params)
      query = apply_tag_filter(query, params[:tag])

      apply_pinned_topics_sort(query, user_sort_sql)
    end

    private

    def set_default_sort(ransack_params)
      ransack_params[:s] ||= DEFAULT_SORT
    end

    def apply_ransack_sorts(ransack_params)
      ransack = Forum::Topic.ransack(ransack_params)
      query   = ransack
                  .result
                  .except(:order)
                  .includes(:category, :tags)

      user_sort_sql = build_ransack_sort_sql(ransack)
      [ ransack, query, user_sort_sql ]
    end

    def apply_tag_filter(query, tag_slug)
      return query unless tag_slug.present?

      tag = Forum::Tag.friendly.find_by(slug: tag_slug)
      return query unless tag

      Forum::Topic
        .where(id: query.joins(:taggables)
                       .where(forum_taggables: { tag_id: tag.id })
                       .select(:id))
        .includes(:category, :tags)
    end

    def apply_pinned_topics_sort(query, user_sort_sql)
      final_sql = user_sort_sql.blank? ? DEFAULT_SORT : user_sort_sql
      query.order(Arel.sql(PINNED_SQL))
           .order(Arel.sql(final_sql))
    end

    def build_ransack_sort_sql(ransack)
      return "" if ransack.sorts.empty?
      ransack.sorts.map { |sort| "#{sort.name} #{sort.dir}" }.join(", ")
    end
  end
end
