class Admin::TempUsersController < Admin::AdminController
  before_action :set_temp_user, only: [:show, :edit, :update, :destroy]

  # GET /facilities
  # GET /facilities.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    condition = { branch_id: session[:branch_id], enable: true  }

    @temp_user_count = TempUser.where(condition).count
    @temp_users = TempUser.where(condition).page(params[:page]).per(params[:per_page])
  end

  # GET /facilities/1
  # GET /facilities/1.json
  def show
  end

  # GET /facilities/new
  def new
    @user = TempUser.new
  end

  # GET /facilities/1/edit
  def edit
  end

  # POST /facilities
  # POST /facilities.json
  def create

  end

  # PATCH/PUT /facilities/1
  # PATCH/PUT /facilities/1.json
  def update
    respond_to do |format|
      if @temp_user.update(temp_users_params)
        format.html { redirect_to @temp_user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @temp_user }
      else
        format.html { render :edit }
        format.json { render json: @temp_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /facilities/1
  # DELETE /facilities/1.json
  def destroy
    @temp_user.destroy
    respond_to do |format|
      format.html { redirect_to admin_temp_users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_temp_user
    @temp_user = TempUser.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def temp_users_params
    params.require(:temp_user).permit(:name,:phone,:email,:gender,:birthday,:request_date,:enable)
  end
end
