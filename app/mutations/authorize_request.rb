class AuthorizeRequest < Mutations::Command
  required do
    string :token
  end

  def execute
    decoded = JsonWebToken.decode(token.split(' ').last)
    user = User.where(email: decoded[:email]) if decoded
    user || add_error(:token, :invalid_token, 'Invalid token')
  end
end
