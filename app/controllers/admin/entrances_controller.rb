class Admin::EntrancesController < Admin::AdminController
  before_action :set_entrance, only: [:show, :edit, :update, :destroy]

  # GET /entrances
  # GET /entrances.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    condition = { users: { branch_id: session[:branch_id], enable: true } }

    @entrance_count = Entrance.joins(:user).where(condition).count
    @entrances = Entrance.select('users.name,entrances.*').joins(:user).where(condition).page(params[:page]).per(params[:per_page]).order('id desc')

    @entrance = nil
    if @entrance_count
      @entrance = @entrances[0]
    end
  end

  # GET /entrances/1
  # GET /entrances/1.json
  def show
  end

  # GET /entrances/new
  def new
    @entrance = Entrance.new
  end

  # GET /entrances/1/edit
  def edit
  end

  # POST /entrances
  # POST /entrances.json
  def create
    @entrance = Entrance.new(entrance_params)

    respond_to do |format|
      if @entrance.save
        format.html { redirect_to [:admin, @entrance], notice: t(:message_success_create) }
        format.json { render :show, status: :created, location: @entrance }
      else
        format.html { render action: 'new' }
        format.json { render json: @entrance.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /entrances/1
  # PATCH/PUT /entrances/1.json
  def update
    respond_to do |format|
      if @entrance.update(entrance_params)
        format.html { redirect_to [:admin, @entrance], notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @entrance }
      else
        format.html { render :edit }
        format.json { render json: @entrance.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entrances/1
  # DELETE /entrances/1.json
  def destroy
    @entrance.destroy
    respond_to do |format|
      format.html { redirect_to admin_attendances_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_entrance
    @entrance = Entrance.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def entrance_params
    params.require(:entrance).permit(:user_id, :in_time, :enable).merge(branch_id: session[:branch_id])
  end
end
