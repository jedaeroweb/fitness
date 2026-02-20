class HomeController < ApplicationController
  load_and_authorize_resource except: [:index]

  def index
    if user_signed_in?
      render 'home/setting'
    else
      render 'home/index'
    end
  end
  
  def no_auth
  
  end
end