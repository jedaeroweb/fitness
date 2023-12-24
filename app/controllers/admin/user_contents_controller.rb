class Admin::UserContentsController < Admin::AdminController
  before_action :set_user_content, only: [:show, :edit, :update, :destroy]

  # GET /user_contents/new
  def new
    @user_content = UserContent.new

    if params[:user_id].present?
      @user = User.where(:id => params[:user_id], :enable => true).first
    end
  end

  # GET /user_contents/1
  # GET /user_contents/1.json
  def show
  end

  # POST /user_content
  # POST /user_content.json
  def create
    @user_content = UserContent.new(user_content_params)

    respond_to do |format|
      if @user_content.save
        format.html { redirect_to [:admin, @user_content.user], notice: t(:message_success_create) }
        format.json { render :show, status: :created, location: @user_content }
      else
        if params[:user_id].present?
          @user = User.where(:id => params[:user_id], :enable => true).first
        end

        format.html { render action: 'new' }
        format.json { render json: @user_content.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_content/1
  # DELETE /user_content/1.json
  def destroy
    user_id=@user_content.user_id

    @user_content.destroy
    respond_to do |format|
      format.html { redirect_to admin_user_path(user_id), notice: 'user_content was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user_content
    @user_content = UserContent.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_content_params
    params.require(:user_content).permit(:user_id, :content, :enable)
  end
end
