class JobMailer < ApplicationMailer
  add_template_helper(ApplicationHelper)
  add_template_helper(JobsHelper)

	default from: ENV['SMTP_SENDER_EMAIL_ADDRESS'] || "from@example.com"

  def apply_email(candidate)
  	@job = candidate.job
    @candidate = candidate
  	mail.attachments["resume.#{extract_extention(candidate.resume.to_s)}"] = File.read(candidate.resume.file.file) if candidate.resume
    mail(to: @job.email, subject: "#{candidate.name} applied #{@job.title} job at #{@job.company_name} in #{@job.location}.")
  end

  def extract_extention(file_name)
  	separate = file_name.split('.')
  	separate[separate.size - 1]
  end
end
