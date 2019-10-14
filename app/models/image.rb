class Image < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  SIZES = {
    thumbnail: { resize: '100x100' },
    standard: { resize: '500x500' }
  }

  def sized(size)
    image.variant(SIZES[size]).processed
  end
end
