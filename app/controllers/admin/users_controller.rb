class Admin::UsersController < Admin::AdminController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  def select
    params[:per_page] = 10 unless params[:per_page].present?

    condition = { branch_id: session[:branch_id], enable: true }
    like = false

    if params[:search_field].present? and params[:search_word].present?
      case params[:search_field]
      when 'name'
        condition_sql = 'name like ?'
        like = true
      when 'phone'
        condition_sql = 'phone like ?'
        like = true
      end
    end

    if like
      @user_count = User.where(condition).where(condition_sql, '%' + params[:search_word].strip + '%').count
      @users = User.where(condition).where(condition_sql, '%' + params[:search_word].strip + '%').page(params[:page]).per(params[:per_page]).order('id desc')
    else
      @user_count = User.where(condition).count
      @users = User.where(condition).page(params[:page]).per(params[:per_page]).order('id desc')
    end
  end
  # GET /users
  # GET /users.json
  def show
    params[:per_page] = 10 unless params[:per_page].present?

    condition = { branch_id: session[:branch_id], enable: true }
    like = false

    if params[:search_field].present? and params[:search_word].present?
      case params[:search_field]
      when 'name'
        condition_sql = 'name like ?'
        like = true
      when 'phone'
        condition_sql = 'phone like ?'
        like = true
      end
    end

    if like
      @user_count = User.where(condition).where(condition_sql, '%' + params[:search_word].strip + '%').count
      @users = User.where(condition).where(condition_sql, '%' + params[:search_word].strip + '%').page(params[:page]).per(params[:per_page]).order('id desc')
    else
      @user_count = User.where(condition).count
      @users = User.where(condition).page(params[:page]).per(params[:per_page]).order('id desc')
    end

    @user = User.find(params[:id])
    @user_additional = UserAdditional.find_by_user_id(@user.id)

    @memo_count = UserContent.where(user_id: @user, enable: true).count
    @memos = UserContent.where(user_id: @user, enable: true).order('id desc')
  end

  # GET /users/new
  def new
    @user = User.new
    @user.build_user_group
    @user.build_user_fc
    @user.build_user_trainer
    @user.build_user_additional
    @user.user_contents.build

    if @current_branch_setting.use_unique_number.present?
      p 1
      @user.build_user_unique_number
    end
  end

  # GET /users/1/edit
  def edit
    @user.build_user_group
    @user.build_user_fc
    @user.build_user_trainer
    @user.build_user_additional

    params[:per_page] = 10 unless params[:per_page].present?

    condition = { branch_id: session[:branch_id], enable: true }

    @user_count = User.where(condition).count
    @users = User.where(condition).page(params[:page]).per(params[:per_page]).order('id desc')

    @user_additional = UserAdditional.find_by_user_id(@user.id)
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to [:admin, @user], notice: t(:message_success_create) }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to admin_user_path(@user), notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        params[:per_page] = 10 unless params[:per_page].present?

        condition = { branch_id: session[:branch_id], enable: true }

        @user_count = User.where(condition).count
        @users = User.where(condition).page(params[:page]).per(params[:per_page]).order('id desc')
        @user = User.find(params[:id])
        @user_additional = UserAdditional.find_by_user_id(@user.id)

        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:group_id, :name, :phone, :birthday, :gender, :registration_date, :enable, user_unique_number_attributes: [:unique_number], user_fc_attributes: [:admin_id], user_trainer_attributes: [:admin_id], user_additional_attributes: [:visit_route_id, :job_id, :company], users_group_attributes: [:group_id], user_contents_attributes: [:content]).merge(branch_id: session[:branch_id])
  end
end
