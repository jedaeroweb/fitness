class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  layout :layout
  before_action :set_locale
  before_action :configure_permitted_parameters, if: :devise_controller?

  def current_ability
    @current_ability ||= AdminAbility.new(current_admin)
  end

  rescue_from CanCan::AccessDenied do |exception|
    session["user_return_to"] = request.fullpath
    redirect_to new_admin_session_path, :notice => t(:login_first)
  end

  def set_locale
    I18n.locale = params[:locale] || session[:locale] || I18n.default_locale
    session[:locale] = I18n.locale
  end

  def layout
    if(params[:no_layout])
      return nil
    else
      return 'application'
    end
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:login_id, :password,
                                                               :password_confirmation, :remember_me, :photo, :photo_cache, :remove_photo).except(:roles_admin__attributes) }
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:login_id, :password,
                                                                      :password_confirmation, :current_password, :photo, :photo_cache, :remove_photor) }
  end
end
