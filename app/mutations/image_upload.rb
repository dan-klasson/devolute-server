class ImageUpload < Mutations::Command
  required do
    string :title
    file :image
    model :user
  end

  def execute
    Image.create!(inputs)
  end
end
