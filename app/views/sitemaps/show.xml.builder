xml.instruct!
xml.urlset xmlns: "http://www.sitemaps.org/schemas/sitemap/0.9" do
  @static_pages.each do |page|
    xml.url do
      xml.loc        page[:url]
      xml.lastmod    page[:updated_at].strftime("%Y-%m-%d")
      xml.changefreq page[:changefreq]
      xml.priority   page[:priority]
    end
  end

  @topics.each do |topic|
    xml.url do
      xml.loc        topic[:url]
      xml.lastmod    topic[:updated_at].strftime("%Y-%m-%d")
      xml.changefreq topic[:changefreq]
      xml.priority   topic[:priority]
    end
  end
end
