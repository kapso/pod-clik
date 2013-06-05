class UserSerializer < BaseSerializer
  attributes :id, :first_name, :last_name, :email, :auth_token, :phone_number, :auth_token

  def auth_token
    object.remember_me_token
  end

  def include_auth_token?
    current_user.id == object.id
  end
end
