class AuthorizeRequest < Mutations::Command
  required do
    string :token
  end

  def execute
    user = User.find(decoded_auth_token[:user_id]) if decoded_auth_token
    user || add_error(:token, :invalid_token, 'Invalid token')
  end

  private

  def decoded_auth_token
    JsonWebToken.decode(token.split(' ').last)
  end
end
