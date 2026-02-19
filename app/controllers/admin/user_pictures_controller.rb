class Admin::UserPicturesController < Admin::AdminController
  before_action :set_user_picture, only: [:show, :destroy]


  # GET /user_content/new
  def new
  end

  # POST /user_contents
  # POST /user_contents.json
  def create
    @user = User.find(user_picture_params[:user_id])

    @user.build_user_picture unless @user.user_picture
    @user.user_picture.assign_attributes(user_picture_params)

    respond_to do |format|
      if @user.user_picture.save
        format.turbo_stream
        format.html { redirect_to admin_user_path(@user), notice: "사진이 업로드되었습니다." }
      else
        format.html { render :new }
      end
    end
  end

  def create_b64
    user = User.find(params[:user_id])

    user_picture = user.user_picture || user.build_user_picture
    user_picture.picture = params[:data_image]

    if user_picture.save
      render turbo_stream: turbo_stream.replace(
        "user_profile_photo_#{user.id}",
        partial: "admin/users/profile_photo",
        locals: { user: user }
      )
    else
      render json: { result: "error", message: "저장 실패" }
    end
  end


  # GET /user_content s/1
  # GET /user_content s/1.json
  def show
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user_picture.destroy
    respond_to do |format|
      format.html { redirect_to admin_user_pictures_url, notice: 'user picture  was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_picture
    @user_picture = UserPicture.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_picture_params
    params.require(:user_picture).permit(:user_id, :picture, :enable)
  end
end
