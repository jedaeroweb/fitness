class Admin::UserPicturesController < Admin::AdminController
  before_action :set_user_picture, only: [:show, :edit, :update, :destroy]

  def layout
    if params[:popup].present?
      return 'admin/new_picture'
    else
      return 'admin/application'
    end
  end

  # GET /user_content/new
  def new
  end

  # POST /user_contents
  # POST /user_contents.json
  def create
    @user_picture = UserPicture.new(user_picture_params)

    respond_to do |format|
      if @user_picture.save
        format.html { redirect_to admin_user_path(@user_picture.user), notice: 'Gg was successfully created.' }
        format.json { render :show, status: :created, location: [:admin, @user_picture] }
      else
        format.html { render :new }
        format.json { render json: @user_picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /user_content s/1
  # GET /user_content s/1.json
  def show
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
