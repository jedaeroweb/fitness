class Admins::RegistrationsController < Devise::RegistrationsController
  layout 'admin/login'
  # GET /admins
  # GET /admins.json
  def index
    @admins = Admin.where('parent_id is null').order('id desc').page(params[:page]).per(10)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @admins }
    end
  end

  def new
    @admin = Admin.new
    @admin.build_admin_picture
  end

  def layout
    if(['edit','update'].include?(params[:action]))
      return 'application'
    else
      return 'admin/application'
    end
  end
  
  # POST /users
  # POST /users.json
  def create
    @company = Company.create!(title: params[:title])
    @branch = Branch.create!(company_id: @company.id, title: '본점')

    ap=admin_params.merge(branch_id: @branch.id)

    @admin = Admin.new(ap)

    respond_to do |format|
      if @admin.save
        format.html { redirect_to new_admin_session_path, :notice => @controller_name +t(:message_success_insert)}
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  def admin_params
    params.require(:admin).permit( :name, :email, :password, :salt, :encrypted_password, admin_picture_attributes: [:picture])
  end
end