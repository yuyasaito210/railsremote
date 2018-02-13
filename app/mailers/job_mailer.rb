class JobMailer < ApplicationMailer
	default from: ENV['SMTP_SENDER_EMAIL_ADDRESS'] || "from@example.com"

  def job_email(job)
  	@job = job
    mail(to: ENV['SMTP_ADMIN_EMAIL_ADDRESS'], subject: 'Sample Email')
  end	
end
