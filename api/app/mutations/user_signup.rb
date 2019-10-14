class UserSignup < Mutations::Command
  required do
    string :email, matches: /^.+@.+$/
    string :password
  end

  def execute
    user = User.create!(inputs)
    payload = { email: inputs[:email], password: inputs[:password] }
    return JsonWebToken.encode(payload) if user

    nil
  end
end
