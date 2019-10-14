logo = Rails.root.join('spec', 'images', 'logo.png')

FactoryBot.define do
  factory :user do
    name { 'Daniel' }
    email { 'dan@example.com' }
    password { 'hax0r' }
  end

  factory :image do
    title { 'some image' }
    image { fixture_file_upload(logo, 'image/png') }
    association :user, factory: :user
  end
end
