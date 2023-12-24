class Users::SessionsController < Devise::SessionsController
    def set_og_title
        @page_title=t(:login)
        if @title
            @og_title = @title
        else
            @og_title = t(:default_title)
        end
    end

    def after_sign_in_path_for(_resource)
        session['user_return_to'] || root_path
    end

    def after_sign_out_path_for(_resource_or_scope)
        if Rails.application.config.i18n.default_locale==I18n.locale
            root_path()
        else
            root_path(:locale=>I18n.locale)
        end
    end
end
