RSpec.describe 'Registration', type: :request do
  it 'successfully creates a new user' do
    post '/registration', params: {
      name: 'Daniel',
      email: 'dan@example.com',
      password: 'hax0r'
    }
    body = JSON.parse(response.body)
    expect(body['success']).to eq true
  end

  it 'fails at creating new user' do
    post '/registration'
    body = JSON.parse(response.body)
    expect(body['success']).to eq false
    expect(body['errors']['name']).to eq 'Name is required'
    expect(body['errors']['email']).to eq 'Email is required'
    expect(body['errors']['password']).to eq 'Password is required'
  end
end
