module ApplicationHelper
  def logged_in?
  	!!session[:user_id]
  end

  def current_user
  	@user = User.find_by(id: session[:user_id]) if logged_in?
  end
end
