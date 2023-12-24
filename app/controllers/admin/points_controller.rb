class Admin::PointsController < Admin::AdminController
  before_action :set_point, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    params[:per_page] = 10 unless params[:per_page].present?

    condition = { users: { branch_id: session[:branch_id], enable: true } }

    @point_count = Point.joins(:users).where(condition).count
    @points = Point.joins(:users).where(condition).page(params[:page]).per(params[:per_page]).order('id desc')
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @point = Point.new
    @point.build_user_point
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @point = Point.new(point_params)

    respond_to do |format|
      if @point.save
        @user_point = UserPoint.find_by_user_id(@point.user_point.user_id)
        @user_point.update(:point => @user_point.point.to_i + @point.point.to_i)
        account = Account.create!(account_category_id: 3, branch_id: session[:branch_id], user_id: @user_point.user_id)

        format.html { redirect_to admin_point_path(@point), notice: 'point was successfully created.' }
        format.json { render :show, status: :created, location: @point }
      else
        @point.build_user_point

        format.html { render :new }
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @point.update(point_params)
        format.html { redirect_to admin_point_path(@point), notice: 'point was successfully updated.' }
        format.json { render :show, status: :ok, location: @point }
      else
        format.html { render :edit }
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @point.destroy
    respond_to do |format|
      format.html { redirect_to admin_points_url, notice: 'point was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_point
    @point = Point.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def point_params
    params.require(:point).permit(:point, :enable, user_point_attributes: [:user_id])
  end
end
