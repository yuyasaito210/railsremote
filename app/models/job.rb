class Job < ActiveRecord::Base
  searchkick
  
  TYPES = {
    "--Select Job Type--" => "Unspecified",
    "Long Term" => "Long Term",
    "Project" => "Project"
  }.freeze

  scope :visible, ->{ where("jobs.visible_until >= ?", Time.now).where(published: true) }
  scope :published, ->{ where(visible_until: nil, published: true) }
  scope :unpublished, ->{ where(visible_until: nil).where(published: [false, nil]) }
  scope :newest_first, ->{ order("jobs.created_at DESC") }

  before_create :generate_token

  after_save :enqueue_create_or_update_document_job
  after_destroy :enqueue_delete_document_job


  def self.separate_title_and_location(query)
    query = query.downcase
    query = query.gsub(' jobs ', ' ')
    query = query.gsub(' job ', ' ')
    query = query.gsub(' in ', ' ')
    query = query.gsub(' at ', ' ')
    query = query.split(' ')
  end

  def self.intelligence_search(query)
    keywords = Job.separate_title_and_location(query)

    results = nil
    keywords.each do |keyword|
      result = Job.search(keyword, fields: [:title, :job_type, :location, :company_name]).records if !keyword.blank?

      if result
        results &= result if results
        results = result unless results
      end
    end
    results
  end

  def self.filtered(type)
    if type.in?(TYPES.values)
      where(job_type: type)
    else
      where("id > 0")
    end
  end

  def self.with_admin_scope(scope)
    if scope
      public_send(scope)
    else
      newest_first
    end
  end

  def expired?
    visible_until && visible_until < Time.now
  end

  def full_title
    "#{title} at #{company_name}"
  end

  def next_visible
    @next_visible ||= self.class.visible.order("created_at ASC").where("created_at > ?", created_at).first
  end

  def prev_visible
    @prev_visible ||= self.class.visible.order("created_at DESC").where("created_at < ?", created_at).first
  end

  def to_param
    "#{id}-remote-#{full_title.parameterize}"
  end

  def type_specified?
    job_type.present? && job_type != "Unspecified"
  end

  def self.template
    default_text = <<-TEMPLATE
      Here's is a simple Markdown template to get you started.

      ### Essential Job Functions

      - List item 1
      - list item 2

      ### Requirements

      ### Benefits

    TEMPLATE
    new(description: default_text.gsub('      ', ''))
  end

  def as_indexed_json(options = {})
    self.as_json(
      only: [:id, :title, :job_type, :description, :location, :published]
    )
  end 

private

  def generate_token
    self.token ||= SecureRandom.hex(100)
  end

  def enqueue_create_or_update_document_job
    Delayed::Job.enqueue CreateOrUpdateSwiftypeDocumentJob.new(self.id)
  end

  def enqueue_delete_document_job
    Delayed::Job.enqueue DeleteSwiftypeDocumentJob.new(self.id)
  end
end
