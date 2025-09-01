module ApplicationHelper
  def admin_user?
    !!session[:is_admin_user]
  end
end
