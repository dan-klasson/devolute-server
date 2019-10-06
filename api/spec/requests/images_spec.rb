RSpec.describe 'Images', type: :request do
  let(:params) do
    file = Rails.root.join('spec', 'images', 'logo.png')
    {
      title: 'some image',
      image: fixture_file_upload(file, 'image/png')
    }
  end

  it 'is uploaded successfully' do
    post '/images', params: params, headers: auth_headers
    body = JSON.parse(response.body)
    puts body
    expect(body['success']).to eq true
    expect(body['result']['title']).to eq 'some image'
    expect(body['result']['user_id']).to eq user.id
  end
end
