class HomeController < ApplicationController
  load_and_authorize_resource

  def index
    if current_user.branch_id==1
      render 'home/setting'
    end
  end
  
  def no_auth
  
  end
end