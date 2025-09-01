module AuthHelper
  def auth_creds
    user = Rails.application.credentials.admin_user
    pass = Rails.application.credentials.admin_password
    ActionController::HttpAuthentication::Basic.encode_credentials(user, pass)
  end
end
