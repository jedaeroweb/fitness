class Admin::JobsController < Admin::AdminController
  before_action :set_job, only: [:show, :edit, :update, :destroy]

  # GET /groups
  # GET /groups.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    condition = { enable: true }

    @job_count = Job.where(condition).count
    @jobs = Job.where(condition).page(params[:page]).per(params[:per_page]).order('id desc')
  end

  def show

  end

  # GET /groups/new
  def new
    @job = Job.new
  end

  # GET /groups/1/edit
  def edit
  end

  # POST /groups
  # POST /groups.json
  def create
    @job = Job.new(job_params)

    respond_to do |format|
      if @job.save
        format.html { redirect_to [:admin, @job], notice: t(:message_success_create) }
        format.json { render :show, status: :created, location: @job }
      else
        format.html { render action: 'new' }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /groups/1
  # PATCH/PUT /groups/1.json
  def update
    respond_to do |format|
      if @job.update(job_params)
        format.html { redirect_to admin_job_path(@job), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @job }
      else
        format.html { render :edit }
        format.json { render json: @job.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /groups/1
  # DELETE /groups/1.json
  def destroy
    @job.destroy
    respond_to do |format|
      format.html { redirect_to admin_jobs_url, notice: 'Job was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_job
    @job = Job.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def job_params
    params.require(:job).permit(:title, :description, :enable)
  end
end
