class AdminJobsController < ApplicationController
  http_basic_authenticate_with name: "superuser", password: ENV['ADMIN_PASSWORD']

  def index
    if params[:q].present?
      @job_title = params[:q]
      results = Job.intelligence_search(params[:q])
      if results && results.size > 0
        @jobs = Kaminari.paginate_array(results).page(params[:page]).per(7)
      else
        # @jobs = @jobs = Job.filtered(params[:q]).page(params[:page]).per_page(7).newest_first
        @jobs = nil
      end
    else
      @job_title = nil
      @jobs = Job.filtered(params[:q]).page(params[:page]).per_page(4).newest_first
    end
    # @jobs = Job.newest_first.with_admin_scope(params[:scope]).page(params[:page]).per_page(4)
    session[:admin] = true
  end

  def update
    # @job = safe_find_job
    @job = Job.where(id: params[:id]).first
    if @job.update_attributes(job_params)
      handle_success
    else
      render action: :show
    end
  end

  def publish 
    job = Job.find(params[:admin_job_id])
    job.update_column(:visible_until, 1.month.from_now)
    redirect_back fallback_location: admin_jobs_path, notice: "Visible until #{job.visible_until}"
  end

  def destroy
    job = Job.find(params[:id])
    job.destroy
    redirect_to admin_jobs_path(scope: :unpublished)
  end

  def edit
    @job = Job.where(id: params[:id]).first!
  end

  def show
    @job = Job.find(params[:id])
    set_meta_tags(
      title: [@job.title, @job.company_name].compact.join(" at "),
      og: {
        type: :article,
        title: :title,
        url: job_url(@job),
        article: {
          section: "Employability",
          published_time: @job.created_at.to_s(:iso8601),
          modified_time: @job.updated_at.to_s(:iso8601),
          expiration_time: @job.visible_until.try(:to_s, :iso8601)
        }
      }
    )
  end

  private

  def safe_find_job
    Job.where(id: params[:id], token: params[:token]).first!
  end

  def job_params
    job_params = params.require(:job).permit(
      :token, :title, :job_type, :company_name, :salary,
      :company_url, :email, :description, :how_to_apply,
      :agencies_ok, :timezone_preferences, :location,
      :resume
    )
    job_params.permit.merge!(published: params[:commit] != "Preview")
    job_params
  end

  def handle_success
    if @job.published
      redirect_to admin_job_path(@job, token: @job.token), notice: "All done! This job will become public once our moderators approve it."
    else
      redirect_to admin_job_path(@job, token: @job.token)
    end
  end

end
