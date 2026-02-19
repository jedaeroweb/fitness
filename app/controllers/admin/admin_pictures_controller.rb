class Admin::AdminPicturesController < Admin::AdminController
  before_action :set_admin_picture, only: [:show, :destroy]

  # GET /user_content/new
  def new
  end

  # GET /user_content s/1
  # GET /user_content s/1.json
  def show
  end

  # POST /user_contents
  # POST /user_contents.json
  def create
    @admin = Admin.find(admin_picture_params[:admin_id])

    @admin.build_admin_picture unless @admin.admin_picture
    @admin.admin_picture.assign_attributes(admin_picture_params)

    respond_to do |format|
      if @admin.admin_picture.save
        format.turbo_stream
        format.html { redirect_to admin_admin_path(@admin), notice: "사진이 업로드되었습니다." }
      else
        format.html { render :new }
      end
    end
  end

  def create_b64
    admin = Admin.find(params[:admin_id])

    admin_picture = admin.admin_picture || admin.build_admin_picture
    admin_picture.picture = params[:data_image]

    if admin_picture.save
      render turbo_stream: turbo_stream.replace(
        "admin_profile_photo_#{admin.id}",
        partial: "admin/admins/profile_photo",
        locals: { admin: admin }
      )
    else
      render json: { result: "error", message: "저장 실패" }
    end
  end

  def destroy
    @user_picture.destroy
    respond_to do |format|
      format.html { redirect_to admin_user_pictures_url, notice: 'user picture  was successfully destroyed.' }
      format.json { head :no_content }
    end
  end


  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_picture
    @user_picture = AdminPicture.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def admin_picture_params
    params.require(:admin_picture).permit(:admin_id, :picture, :enable)
  end
end
