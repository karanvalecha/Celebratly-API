class StatusUpload < ApplicationRecord
  belongs_to :occurrence
  belongs_to :user

  has_one_attached :image_upload, service: :cloudinary_images
end
