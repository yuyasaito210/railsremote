class CrawlBase
  def self.config
    {
      url: nil,
      base_url: nil,
      list_link_selector: nil,
    }.freeze
  end

  def self.call
    doc = Fetch.new(config[:url]).doc
    edit_links = doc.css(config[:list_link_selector]).map do |a|
      path = a.attr('href')
      puts "-> #{path}"
      attrs = new("#{config[:base_url]}#{path}").to_h
      unless Job.where(attrs.slice(:title, :company_name)).any?
        job = Job.new attrs
        if job.save
          base = Rails.env.development? ? "http://localhost:3000" : "http://www.railsremote.com"
          "\t-> √. #{base}/jobs/#{job.id}/edit?token=#{job.token}"
        else
          "\t-> X. #{job.errors.full_messages}"
        end
      end
    end
    puts "No links found" unless edit_links.present?
    puts edit_links.join("\n")
  end

  def initialize(url, fetcher_class: Fetch)
    @url = url
    @fetcher_class = fetcher_class
  end

  def to_h
    raise "No implemented"
  end

private

  def doc
    @doc ||= begin
      fetcher = @fetcher_class.new @url
      fetcher.doc
    end
  end
end
