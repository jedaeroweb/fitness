class Users::SessionsController < Devise::SessionsController
    def create
        super

        #require 'ipaddr'
        #UserLoginLog.create!(admin_id: current_admin.id, client_ip: IPAddr.new(request.remote_ip).to_i)

        branch_id=current_user.branch_id
        session[:branch_id]=branch_id

        #branch=Branch.find(branch_id)
        #if branch.company.premium
        #    session[:premium]=true
        #end
    end

    def after_sign_out_path_for(_resource_or_scope)
        if Rails.application.config.i18n.default_locale == I18n.locale
            new_user_session_path()
        else
            new_user_session_path(:locale => I18n.locale)
        end
    end
end
