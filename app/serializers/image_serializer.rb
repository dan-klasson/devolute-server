class ImageSerializer < ActiveModel::Serializer
  include Rails.application.routes.url_helpers
  attributes :id, :title, :standard, :thumbnail

  def standard
    url_for(object.sized(:standard))
  end

  def thumbnail
    url_for(object.sized(:thumbnail))
  end
end
