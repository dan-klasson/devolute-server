class UserLogin < Mutations::Command
  required do
    string :email, matches: /^.+@.+$/
    string :password
  end

  def execute
    payload = { email: inputs[:email], password: inputs[:password] }
    JsonWebToken.encode(payload) if user
  end

  private

  def user
    user = User.find_by_email(inputs[:email])
    return user if user&.authenticate(inputs[:password])

    add_error :user_authentication, :invalid_credentials, 'Invalid credentials'
    nil
  end
end
