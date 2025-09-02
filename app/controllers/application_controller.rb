class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  helper_method :admin?

  # Query-only check for views/controllers that shouldn't 401-challenge.
  def admin?
    return @_is_admin if defined?(@_is_admin)

    # Parse header if present; no challenge sent.
    authenticated = authenticate_with_http_basic do |user, password|
      credentials_match?(user, password)
    end

    @_is_admin = !!authenticated
  end

  protected

  # Use in controllers that should 401-challenge when not admin.
  def require_admin!
    # Optionally short-circuit if credentials are not configured.
    unless admin_user.present? && admin_password.present?
      return head :unauthorized
    end

    authenticate_or_request_with_http_basic("Admin Area") do |user, password|
      credentials_match?(user, password)
    end
  end

  private

  def admin_user
    Rails.application.credentials.admin_user.to_s
  end

  def admin_password
    Rails.application.credentials.admin_password.to_s
  end

  # Constant-time, equal-length comparison using digests.
  def credentials_match?(user, password)
    return false if user.blank? || password.blank?
    u  = ::Digest::SHA256.hexdigest(user.to_s)
    pu = ::Digest::SHA256.hexdigest(admin_user)
    p  = ::Digest::SHA256.hexdigest(password.to_s)
    pp = ::Digest::SHA256.hexdigest(admin_password)

    ActiveSupport::SecurityUtils.secure_compare(u,  pu) &&
      ActiveSupport::SecurityUtils.secure_compare(p, pp)
  end
end
