RSpec.describe 'AuthorizeRequest' do
  before(:each) { @user = create(:user) }

  it 'succesfully authorizes the user' do
    outcome = AuthorizeRequest.run(token: token)
    expect(outcome.success?).to eq(true)
    expect(outcome.result).to eq(user)
  end

  context 'has error' do
    it 'invalid token' do
      outcome = AuthorizeRequest.run(token: 'invalid token')
      expect(outcome.success?).to eq(false)
      expect(outcome.errors.message_list).to include('Invalid token')
    end

    it 'missing token' do
      outcome = AuthorizeRequest.run(token: '')
      expect(outcome.success?).to eq(false)
      expect(outcome.errors.message_list).to include("Token can't be blank")
    end
  end
end
