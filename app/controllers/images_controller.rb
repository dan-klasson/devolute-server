class ImagesController < ApplicationController
  def index
    images = Image.where(user: current_user)
    render json: images, each_serializer: ImageSerializer
  end

  def create
    json_response ImageUpload.run(params.merge(user: current_user))
  end
end
