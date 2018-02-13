class CreateOrUpdateSwiftypeDocumentJob < Struct.new(:job_id)
  def perform
    job = Job.find(job_id)
    url = Rails.application.routes.url_helpers.job_url(job)
    client = Swiftype::Client.new
    
    client.create_or_update_document(ENV['SWIFTYPE_ENGINE_SLUG'],
                                     Job.model_name.plural,
                                     {external_id: job.id,
                                       fields: [{name: 'title', value: job.title, type: 'string'},
                                                   {name: 'job_type', value: job.job_type, type: 'string'},
                                                   {name: 'company_name', value: job.company_name, type: 'string'},
                                                   {name: 'salary', value: job.salary, type: 'string'},
                                                   {name: 'location', value: job.location, type: 'string'},
                                                   {name: 'email', value: job.email, type: 'string'},
                                                   {name: 'company_url', value: job.company_url, type: 'string'},
                                                   {name: 'description', value: job.description, type: 'text'},
                                                   {name: 'url', value: url, type: 'enum'},
                                                   {name: 'created_at', value: job.created_at.iso8601, type: 'date'}]})
  end
end
