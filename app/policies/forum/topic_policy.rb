class Forum::TopicPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end

  def edit?
    update?
  end

  def update?
    user.has_any_role?(:admin, :moderator) || user == record.user
  end

  def update_pinned?
    destroy?
  end

  def destroy?
    user.has_any_role?(:admin, :moderator)
  end
end
