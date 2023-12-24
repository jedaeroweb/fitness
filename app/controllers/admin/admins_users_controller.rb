class Admin::AdminsUsersController < Admin::AdminController
  before_action :set_employee, only: [:show, :edit, :update, :destroy]

  def index
    params[:per_page] = 10 unless params[:per_page].present?

    condition = { branch_id: session[:branch_id], enable: true }

    @employee_count = Admin.where(condition).count
    @employees = Admin.where(condition).page(params[:page]).per(params[:per_page]).order('id desc')

    @employee_content = nil
    if @employee_count
      @employee_content = @employees[0]
    end
  end

  # GET /employees
  # GET /employees.json
  def show
  end

  # POST /employees
  # POST /employees.json
  def create
    @employee = Employee.new(employee_params)

    respond_to do |format|
      if @employee.save
        format.html { redirect_to @employee, notice: 'Admin was successfully created.' }
        format.json { render :show, status: :created, location: @employee }
      else
        format.html { render :new }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /employees/1
  # PATCH/PUT /employees/1.json
  def update
    respond_to do |format|
      if @employee.update(employee_params)
        format.html { redirect_to @employee, notice: 'Admin was successfully updated.' }
        format.json { render :show, status: :ok, location: @employee }
      else
        format.html { render :edit }
        format.json { render json: @employee.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /employees/1
  # DELETE /employees/1.json
  def destroy
    @employee.destroy
    respond_to do |format|
      format.html { redirect_to admin_employees_url, notice: 'Admin was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_employee
    @employee = Employee.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def employee_params
    params.require(:employee).permit(:login_id, :password, :name, :email, :phone, :gender, :birthday, :is_fc, :is_trainer, :commission_rate, :registration_date, :enable, roles_admin_attributes: [:role_id], admin_content_attributes: [:content]).merge(branch_id: session[:branch_id])
  end
end
