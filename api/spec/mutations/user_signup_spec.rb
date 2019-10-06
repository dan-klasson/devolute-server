RSpec.describe 'UserSignup' do
  let(:params) do
    {
      name: 'Daniel',
      email: 'dan@example.com',
      password: 'hax0r'
    }
  end

  it 'signs the user up' do
    outcome = UserSignup.run(params)
    expect(outcome.success?).to eq(true)
    expect(outcome.result).to eq(User.first)
  end

  it 'validates correct email' do
    params[:email] = 'invalid email'
    outcome = UserSignup.run(params)
    expect(outcome.success?).to eq(false)
    message = "Email isn't in the right format"
    expect(outcome.errors.message_list).to include(message)
  end

  it 'validates required fields' do
    outcome = UserSignup.run({})
    expect(outcome.success?).to eq(false)
    expect(outcome.errors.message_list).to include('Name is required')
    expect(outcome.errors.message_list).to include('Email is required')
    expect(outcome.errors.message_list).to include('Password is required')
  end
end
