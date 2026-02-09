class Admin::CheckInsController < Admin::AdminController
  before_action :set_check_in, only: [:show, :edit, :update, :destroy]

  # GET /check_ins
  # GET /check_ins.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    condition = { users: { branch_id: session[:branch_id], enable: true } }

    @check_in_count = CheckIn.joins(:user).where(condition).count
    @check_ins = CheckIn.select('users.name,check_ins.*').joins(:user).where(condition).page(params[:page]).per(params[:per_page]).order('id desc')

    @check_in = nil
    if @check_in_count
      @check_in = @check_ins[0]
    end
  end

  # GET /check_ins/1
  # GET /check_ins/1.json
  def show
  end

  # GET /check_ins/new
  def new
    @check_in = CheckIn.new
  end

  # GET /check_ins/1/edit
  def edit
  end

  # POST /check_ins
  # POST /check_ins.json
  def create
    @check_in = CheckIn.new(check_in_params)

    respond_to do |format|
      if @check_in.save
        redirect_path =
          params[:redirect_to].presence ||
          [:admin, @check_in]

        format.html do
          redirect_to redirect_path, notice: t(:message_success_create)
        end

        format.json { render :show, status: :created, location: @check_in }
      else
        format.html { render :new }
        format.json { render json: @check_in.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /check_ins/1
  # PATCH/PUT /check_ins/1.json
  def update
    respond_to do |format|
      if @check_in.update(check_in_params)
        format.html { redirect_to [:admin, @check_in], notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @check_in }
      else
        format.html { render :edit }
        format.json { render json: @check_in.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /check_ins/1
  # DELETE /check_ins/1.json
  def destroy
    @check_in.destroy
    respond_to do |format|
      format.html { redirect_to admin_check_ins_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_check_in
    @check_in = CheckIn.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def check_in_params
    params.require(:check_in).permit(:user_id, :in_time, :enable).merge(branch_id: session[:branch_id])
  end
end
