class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected
  def current_user
    @user ||= begin
      if (auth_token = request.headers[Settings.auth_token_key]).present? && (user = User.find_by_auth_token(auth_token))
        user.update(last_activity_at: Time.now)
        user
      end
    end
  end

  def require_auth!
    render_error 'Request failed, auth token is required for this request', :unauthorized if !logged_in?
  end

  def permitted_params
    @permitted_params ||= PermittedParams.new(params, current_user)
  end

  def render_error(errors, status = :internal_server_error)
    render json: { errors: [*errors] }, status: status
  end
end
