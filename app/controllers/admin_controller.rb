class AdminController < ApplicationController
  http_basic_authenticate_with name: Rails.application.credentials.admin_user, password: Rails.application.credentials.admin_password
end
