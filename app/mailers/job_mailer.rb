class JobMailer < ApplicationMailer
  add_template_helper(ApplicationHelper)
  add_template_helper(JobsHelper)

	default from: ENV['SMTP_SENDER_EMAIL_ADDRESS'] || "from@example.com"

  def job_email(job)
  	@job = job
    mail(to: ENV['SMTP_ADMIN_EMAIL_ADDRESS'], subject: "1 new #{@job.job_type} job in #{@job.location}.")
  end	
end
