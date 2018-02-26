class CandidatesController < ApplicationController
  before_action :set_candidate, only: [:show, :edit, :update, :destroy]

  # GET /candidates
  def index
    @candidates = Candidate.all
  end

  # GET /candidates/1
  def show
  end

  # GET /candidates/new
  def new
    @candidate = Candidate.new
  end

  # GET /candidates/1/edit
  def edit
  end

  # POST /candidates
  def create
    @job = Job.find(params[:candidate][:job_id])
    @candidate = Candidate.new(candidate_params)
    if @candidate.save
      begin
        JobMailer.apply_email(@candidate).deliver
        JobMailer.apply_confirm_email(@candidate).deliver
        flash[:success] = "sent email successfully"
      rescue Net::SMTPAuthenticationError, Net::SMTPServerBusy, Net::SMTPSyntaxError, Net::SMTPFatalError, Net::SMTPUnknownError => e
        flash[:error] = "Problems sending mail. #{e.to_s}"
        Rails.logger.info "=== mail error: #{e.to_s}"
      end
      redirect_to jobs_path
    else
      flash[:error] = @job.errors.full_messages
      redirect_to job_path @job
    end
  end

  # PATCH/PUT /candidates/1
  def update
    if @candidate.update(candidate_params)
      redirect_to @candidate, notice: 'Candidate was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /candidates/1
  def destroy
    @candidate.destroy
    redirect_to candidates_url, notice: 'Candidate was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_candidate
      @candidate = Candidate.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def candidate_params
      params.require(:candidate).permit(:name, :phone_number, :email, :resume, :job_id)
    end
end
