RSpec.describe 'Authenticate', type: :request do
  before(:each) do
    @user = User.create!(params)
  end
  let(:params) do
    {
      email: 'dan@example.com',
      password: 'hax0r'
    }
  end

  it 'is successful' do
    post '/authentication', params: params
    body = JSON.parse(response.body)
    token = JsonWebToken.encode(user_id: @user.id)
    expect(body['success']).to eq true
    expect(body['result']).to eq token
  end

  context 'has error' do
    it 'wrong credentials' do
      params[:password] = 'wrong password'
      post '/authentication', params: params
      body = JSON.parse(response.body)
      expect(body['success']).to eq false
      expect(body['errors']['user_authentication']).to eq 'Invalid credentials'
    end

    it 'missing parameters' do
      post '/authentication'
      body = JSON.parse(response.body)
      expect(body['success']).to eq false
      expect(body['errors']['email']).to eq 'Email is required'
      expect(body['errors']['password']).to eq 'Password is required'
    end
  end
end
