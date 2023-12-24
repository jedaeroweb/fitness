class Admin::AdminPicturesController < Admin::AdminController
  before_action :set_admin_picture, only: [:show, :edit, :update, :destroy]

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
    @admin_picture = AdminPicture.new(admin_picture_params)

    respond_to do |format|
      if @admin_picture.save
        format.html { redirect_to admin_admin_path(@admin_picture.admin), notice: 'Gg was successfully created.' }
        format.json { render :show, status: :created, location: [:admin, @admin_picture] }
      else
        format.html { render :new }
        format.json { render json: @admin_picture.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /user_content s/1
  # GET /user_content s/1.json
  def show
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
