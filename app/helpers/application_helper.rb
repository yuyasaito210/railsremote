module ApplicationHelper
  def md(text)
    @markdown ||= Redcarpet::Markdown.new(MyCarpet,
      autolink: true, no_intra_emphasis: true,
      filter_html: true, no_styles: true,
      link_attributes: { target: '_blank' },
      autolink_attributes: { target: '_blank' }
    )
    @markdown.render(text).html_safe
  end

  def url_with_protocol(url)
    /^http/i.match(url) ? url : "http://#{url}"
  end
end

class MyCarpet < Redcarpet::Render::HTML
  def header(text, header_level)
    level = [3, header_level.to_i].max
    "<h#{level}>#{text}</h#{level}>"
  end

  def link(link, title, alt_text)
    "<a target=\"_blank\" href=\"#{link}\">#{alt_text}</a>"
  end

  def autolink(link, link_type)
    "<a target=\"_blank\" href=\"#{link}\">#{link}</a>"
  end
end
