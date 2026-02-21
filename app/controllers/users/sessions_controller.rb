class Users::SessionsController < Devise::SessionsController
  def create
    self.resource = warden.authenticate(auth_options)

    if resource && resource.admin.present?
      sign_in(resource_name, resource)
      session[:admin_id] = resource.admin.id
    else
      sign_out(resource)
      redirect_to new_user_session_path, alert: "관리자 권한이 없습니다"
    end
  end

    def after_sign_out_path_for(_resource_or_scope)
        if Rails.application.config.i18n.default_locale == I18n.locale
            new_user_session_path()
        else
            new_user_session_path(:locale => I18n.locale)
        end
    end
end
