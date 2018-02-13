class DeleteSwiftypeDocumentJob < Struct.new(:job_id)
  def perform
    client = Swiftype::Client.new
    client.destroy_document(ENV['SWIFTYPE_ENGINE_SLUG'], Job.model_name.plural, job_id)
  end
end
