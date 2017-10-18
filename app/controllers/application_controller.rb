class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  def isLogin
    if session[:current_user].nil?
        redirect_to login_path
    end
  end

  def isLoged
    if session[:current_user]
        redirect_to index_path
    end
  end

  def loginTo(user)
    session[:current_user] = user.id
  end
  
end
