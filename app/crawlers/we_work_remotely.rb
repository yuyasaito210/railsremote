class WeWorkRemotely < CrawlBase
  def self.config
    {
      url: "https://weworkremotely.com/jobs/search?term=rails",
      base_url: "https://weworkremotely.com",
      list_link_selector: "article li a",
    }.freeze
  end

  def to_h
    {
      company_name: doc.css(".listing-header-container .company").first.try(:text),
      title: doc.css(".listing-header-container h1").first.try(:text),
      company_url: doc.css(".listing-header-container h2 a").first.try(:text),
      how_to_apply: doc.css(".apply p").first.try(:text),
      description: ReverseMarkdown.convert(doc.css(".job .listing-container").first.try(:to_html)).to_s.strip
    }
  end
end
