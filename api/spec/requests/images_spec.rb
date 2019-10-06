RSpec.describe 'Images', type: :request do
  context 'index' do
    before(:each) { create_list(:image, 5, user: user) }
    it 'lists all my images' do
      get '/images', headers: auth_headers
      body = JSON.parse(response.body)
      expect(body.count).to eq(5)
      expect(body.first['title']).to eq('some image')
      expect(body.first['standard']).to include('logo.png')
      expect(body.first['thumbnail']).to include('logo.png')
    end
  end

  context 'create' do
    let(:params) do
      file = Rails.root.join('spec', 'images', 'logo.png')
      {
        title: 'some image',
        image: fixture_file_upload(file, 'image/png')
      }
    end
    it 'was successful' do
      post '/images', params: params, headers: auth_headers
      body = JSON.parse(response.body)
      expect(body['success']).to eq true
      expect(body['result']['title']).to eq 'some image'
      expect(body['result']['user_id']).to eq user.id
    end
  end
end
