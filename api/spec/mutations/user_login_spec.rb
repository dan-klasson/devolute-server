RSpec.describe 'UserLogin' do
  before(:each) do
    @user = User.create!(params)
  end
  let(:params) do
    {
      email: 'dan@example.com',
      password: 'hax0r'
    }
  end

  it 'succesfully logs the user in' do
    outcome = UserLogin.run(params)
    token = JsonWebToken.encode(user_id: @user.id)
    expect(outcome.success?).to eq(true)
    expect(outcome.result).to eq(token)
  end

  context 'has error' do
    it 'invalid password' do
      params[:password] = 'wrong password'
      outcome = UserLogin.run(params)
      expect(outcome.success?).to eq(false)
      message = 'Invalid credentials'
      expect(outcome.errors.message_list).to include(message)
    end

    it 'invalid email' do
      params[:email] = 'invalid email'
      outcome = UserLogin.run(params)
      expect(outcome.success?).to eq(false)
      message = "Email isn't in the right format"
      expect(outcome.errors.message_list).to include(message)
    end

    it 'missing parameters' do
      outcome = UserLogin.run({})
      expect(outcome.success?).to eq(false)
      expect(outcome.errors.message_list).to include('Email is required')
      expect(outcome.errors.message_list).to include('Password is required')
    end
  end
end
