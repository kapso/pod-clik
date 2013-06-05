class PermittedParams < Struct.new(:params, :user)
  USER_ATTRIBUTES = %i(first_name last_name email time_zone phone_number school_id)

  def user
    params.require(:user).permit(*USER_ATTRIBUTES)
  end
end
