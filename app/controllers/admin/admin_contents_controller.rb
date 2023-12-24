class Admin::AdminContentsController < Admin::AdminController
  before_action :set_admin_content, only: [:show, :edit, :update, :destroy]

  # GET /user_content/new
  def new
    @user_content = AdminContent.new

    if params[:admin_id].present?
      @user = Admin.where(:id => params[:admin_id], :enable => true).first
    end
  end

  def show

  end

  # POST /user_contents
  # POST /user_contents.json
  def create
    @admin_content = AdminContent.new(admin_content_params)

    respond_to do |format|
      if @admin_content.save
        format.html { redirect_to [:admin, @admin_content.admin], notice: t(:message_success_create) }
        format.json { render :show, status: :created, location: @admin_content }
      else
        if params[:admin_id].present?
          @admin = Admin.where(:id => params[:admin_id], :enable => true).first
        end

        format.html { render action: 'new' }
        format.json { render json: @admin_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # GET /user_content s/1
  # GET /user_content s/1.json
  def show
  end

  # DELETE /user_content/1
  # DELETE /user_content/1.json
  def destroy
    admin_id=@admin_content.admin_id

    @admin_content.destroy
    respond_to do |format|
      format.html { redirect_to admin_admin_path(admin_id), notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin_content
    @admin_content = AdminContent.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def admin_content_params
    params.require(:admin_content).permit(:admin_id, :content, :enable)
  end
end
