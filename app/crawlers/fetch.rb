require 'open-uri'
class Fetch
  def initialize(url)
    @url = url
  end

  def doc
    Nokogiri.parse open(@url).read
  end
end
