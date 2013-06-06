class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  rescue_from Exception, with: :render_exception if %w(staging).include?(Rails.env)

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
    render_error(I18n.t('errors.not_signed_in'), :unauthorized) if !logged_in?
  end

  def permitted_params
    @permitted_params ||= PermittedParams.new(params, current_user)
  end

  def render_error(errors, status = :internal_server_error)
    render json: { errors: [*errors] }, status: status
  end

  def render_exception(e)
    logger.error "ERROR! #{e.class}: #{e.message}"

    case e
    when ActiveRecord::RecordNotFound
      render_error I18n.t('errors.record_not_found'), :not_found
    else
      render_error I18n.t('errors.server_issue')
    end
  end
end
