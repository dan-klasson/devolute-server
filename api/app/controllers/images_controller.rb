class ImagesController < ApplicationController
  def create
    json_response ImageUpload.run(
      title: params[:title],
      image: params[:image],
      user: current_user
    )
  end
end
