class AdminController < ApplicationController
  http_basic_authenticate_with name: Rails.application.credentials.admin_user, password: Rails.application.credentials.admin_password

  # this is meant as a shortcut to logging in. navigate to `/admin`
  # to trigger basic auth, and then store a flag in the session so
  # that admin links are displayed on public pages.
  #
  # don't use `is_admin_user` for anything requiring auth, it's
  # only to make the UX a bit smoother. anything requiring admin
  # permissions needs to go through `/admin` and login there.
  def login
    session[:is_admin_user] = true
    redirect_to root_path
  end

  # this doesn't actually logout, that's managed by the browser.
  # just clears the flag, mostly for testing.
  def logout
    session[:is_admin_user] = false
    redirect_to root_path
  end
end
