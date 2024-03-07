class Users::SessionsController < Devise::SessionsController
    def create
        super

        #require 'ipaddr'
        #UserLoginLog.create!(admin_id: current_user.id, client_ip: IPAddr.new(request.remote_ip).to_i)

        branch_id=current_user.branch_id
        session[:branch_id]=branch_id

        unless current_user.user_admins_count.zero?
            user=User.find(current_user.id)
            session[:admin_id] = user.admin.id
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
