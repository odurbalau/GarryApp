class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user
  helper_method :link_to_submit
  helper_method :findFriends
  helper_method :findInterests
  private
  
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
  
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
  
  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to login_url
      return false
    end
  end
  
  def store_location
      session[:return_to] = request.fullpath
  end
  
  def redirect_back_or_default
    if session[:return_to]
      redirect_to(session[:return_to])
      session[:return_to] = nil
    else
      redirect_to users_path
    end
  end
  
    
end
