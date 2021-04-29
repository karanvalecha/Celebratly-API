class Occurrence < ApplicationRecord
  belongs_to :event

  has_one :reference, through: :event, source_type: 'User'
  has_many :status_uploads, dependent: :destroy


  has_one_attached :published_video, service: :cloudinary_compiled_videos

  def slug
    "#{event.name} #{id}".parameterize
  end

  def upload_folder
    slug
  end
end
  