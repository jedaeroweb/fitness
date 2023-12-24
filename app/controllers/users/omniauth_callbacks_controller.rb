class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include OmniConcern
  %w[facebook twitter kakao google_oauth2].each do |meth|
    define_method(meth) do
      create
    end
  end
end
