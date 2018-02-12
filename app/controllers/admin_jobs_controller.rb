class AdminJobsController < ApplicationController
  http_basic_authenticate_with name: "superuser", password: ENV['ADMIN_PASSWORD']

  def index
    @jobs = Job.newest_first.with_admin_scope(params[:scope])
    session[:admin] = true
  end

  def update
    job = Job.find(params[:id])
    job.update_column(:visible_until, 1.month.from_now)
    redirect_to :back, notice: "Visible until #{job.visible_until}"
  end

  def destroy
    job = Job.find(params[:id])
    job.destroy
    redirect_to admin_jobs_path(scope: :unpublished)
  end
end
