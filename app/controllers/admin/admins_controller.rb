class Admin::AdminsController < Admin::AdminController
  before_action :set_admin, only: [:show, :edit, :update, :destroy]

  def index
    params[:per_page] = 10 unless params[:per_page].present?

    condition = { branch_id: session[:branch_id], enable: true }

    @admin_count = Admin.where(condition).count
    @admins = Admin.where(condition).page(params[:page]).per(params[:per_page]).order('id desc')

    @admin = nil
    if @admin_count
      @admin = @admins[0]
    end
  end

  # GET /employees
  # GET /employees.json
  def show
    params[:per_page] = 10 unless params[:per_page].present?

    condition = { branch_id: session[:branch_id], enable: true }

    @admin_count = Admin.where(condition).count
    @admins = Admin.where(condition).page(params[:page]).per(params[:per_page]).order('id desc')
    @admin = Admin.find(params[:id])
  end



  # GET /employees/new
  def new
    @admin = Admin.new
    @admin.build_role_admin
    @admin.admin_contents.build
  end

  # GET /employees/1/edit
  def edit
    params[:per_page] = 10 unless params[:per_page].present?

    condition = { branch_id: session[:branch_id], enable: true }

    @admin_count = Admin.where(condition).count
    @admins = Admin.where(condition).page(params[:page]).per(params[:per_page]).order('id desc')
  end

  # POST /employees
  # POST /employees.json
  def create
    @admin = Admin.new(admin_params)

    respond_to do |format|
      if @admin.save
        format.html { redirect_to admin_admin_path(@admin), notice: 'Admin was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end


  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @admin.update(admin_params)
        format.html { redirect_to admin_admin_path(@admin), notice: 'Admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin }
      else
        format.html { render :edit }
        format.json { render json: @admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @admin.destroy
    respond_to do |format|
      format.html { redirect_to admin_employees_url, notice: 'Admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_admin
    @admin = Admin.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def admin_params
    params.require(:admin).permit(:email, :password, :salt, :encrypted_password, :name, :phone, :gender, :birthday, :is_fc, :is_trainer, :commission_rate, :registration_date, :enable, roles_admin_attributes: [:role_id], admin_content_attributes: [:content]).merge(branch_id: session[:branch_id])
  end
end
