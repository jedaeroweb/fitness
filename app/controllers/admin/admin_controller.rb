class Admin::AdminController < ApplicationController
  #load_and_authorize_resource except: [:create]
  load_and_authorize_resource
  before_action :set_branch_setting

  def initialize(*params)
    super(*params)
    before_init
  end

  helper_method :current_admin

  def current_admin
    current_user&.admin
  end

  def before_init
    #  @script='admin/application'
    # @contact_count=Contact.where(:confirm=>false).count
  end

  def set_branch_setting
    if session[:branch_id]
      @current_branch = Branch.where(id: session[:branch_id], enable: true).first
    else
      @current_branch = Branch.where(id: current_user.branch_id, enable: true).first
      session[:branch_id]=@current_branch.id
    end
    @current_branch_setting = BranchSetting.where(branch_id: @current_branch, enable: true).first

    @use_point = false
    @current_branch_setting.branch_setting_payments.each do |bsp|
      if bsp.id == 3
        @use_point = true
      end
    end
  end

  def current_ability
    @current_ability ||= AdminAbility.new(current_admin)
  end

  def resource_name
    :admin
  end

  def resource
    @resource ||= Admin.new
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  rescue_from CanCan::AccessDenied do |_exception|
    if current_admin
      render file: "#{Rails.root}/public/403.html", status: 403, layout: false
    else
      redirect_to new_user_session_path
    end
  end

  def layout
    if params[:no_layout]
      false
    else
      if params[:popup]
        'admin/popup'
      else
        'admin/application'
      end
    end
  end
end
