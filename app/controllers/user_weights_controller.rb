class UserWeightsController < ApplicationController
  load_and_authorize_resource
  before_action :set_user_weight, only: [:show, :edit, :create, :update, :destroy]

  # GET /Users/new
  def new
  end

  # GET /Users/1/edit
  def edit
  end

  # POST /Users
  # POST /Users.json
  def create
    respond_to do |format|
      if @user.update(user_weight_params)
        format.html { redirect_to root_path, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /Users/1
  # PATCH/PUT /Users/1.json
  def update
    respond_to do |format|
      if @user.update(user_weight_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user_weight
    @user = User.find(current_user.id)
  end

  # Only allow a list of trusted parameters through.
  def user_weight_params
    params.require(:user_weight).permit(:weight)
  end
end
