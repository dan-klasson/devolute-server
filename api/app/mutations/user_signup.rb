class UserSignup < Mutations::Command
  required do
    string :email, matches: /^.+@.+$/
    string :name
    string :password
  end

  def execute
    User.create!(inputs)
  end
end
