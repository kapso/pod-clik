class AuthController < ApplicationController
  before_action :require_auth!, only: %i(signout phone)

  # POST /auth/signin
  def signin
    if params[:phone_number].present? && (@user = User.find_by_phone_number(params[:phone_number])).blank?
      render_error(I18n.t('errors.signin.invalid_phone_number'), :not_found) and return
    end

    if params[:email].present? && (@user = User.find_by_email(params[:email])).blank?
      render_error(I18n.t('errors.signin.invalid_email'), :not_found) and return
    end

    if @user && @user.password_match?(params[:password])
      @user.signin!
      render json: @user
    else
      render_error I18n.t('errors.signin.invalid_credentials'), :not_found
    end
  end

  # POST /auth/signout
  def signout
    current_user.signout!
    head :no_content
  end

  # POST /auth/phone
  def phone
    if params[:code] == current_user.phone_auth_code
      current_user.update phone_verified: true
      head :ok
    else
      head :not_found
    end
  end
end
