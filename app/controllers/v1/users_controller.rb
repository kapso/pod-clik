class V1::UsersController < ApplicationController
  before_action :require_auth!, only: %i(me show update)
  before_action :load_user, only: %i(show)
  before_action :load_school, only: %i(create update)

  # GET /v1/users/:id
  def show
    render json: @user
  end

  # GET /v1/users/self
  def me
    render json: current_user
  end

  # POST /v1/users
  def create
    render_error(I18n.t('errors.users.create.invalid_school'), :unprocessable_entity) and return if @school.blank?
    render_error(I18n.t('errors.users.create.email_taken'), :unprocessable_entity) and return if User.exists?(email: params[:user][:email])
    render_error(I18n.t('errors.users.create.iphone_number_taken'), :unprocessable_entity) and return if User.exists?(phone_number: params[:user][:phone_number])

    @user = User.new permitted_params.user

    if @user.save
      render json: @user, status: :created
    else
      render_error @user.errors.full_messages, :unprocessable_entity
    end
  end

  # PUT /v1/users/:id
  def update
    render_error(I18n.t('errors.users.create.invalid_school'), :unprocessable_entity) and return if @school.blank?

    if current_user.update(permitted_params.user)
      head :no_content
    else
      render_eror current_user.errors.full_messages, :unprocessable_entity
    end
  end

  private
  def load_user
    @user = User.find params[:id]
  end

  def load_school
    @school = School.find_by_id(params[:user].try(:[], :school_id))
  end
end
