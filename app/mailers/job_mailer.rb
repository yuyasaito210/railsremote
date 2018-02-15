class JobMailer < ApplicationMailer
  add_template_helper(ApplicationHelper)
  add_template_helper(JobsHelper)

	default from: ENV['SMTP_SENDER_EMAIL_ADDRESS'] || "from@example.com"

  def job_email(job)
  	@job = job
  	Rails.logger.info ("==== job.resume: #{job.resume.inspect}")
  	Rails.logger.info ("==== resume: #{job.resume.to_s}")
  	Rails.logger.info ("==== filename: #{job.resume.file.file}")
  	mail.attachments["resume.#{extract_extention(job.resume.to_s)}"] = File.read(job.resume.file.file) if job.resume
    mail(to: job.email, subject: "1 new #{@job.job_type} job in #{@job.location}.")
  end

  def extract_extention(file_name)
  	separate = file_name.split('.')
  	separate[separate.size - 1]
  end
end
