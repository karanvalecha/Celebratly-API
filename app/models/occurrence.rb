class Occurrence < ApplicationRecord
  belongs_to :event

  has_one :reference, through: :event, source_type: 'User'
  has_many :status_uploads, dependent: :destroy


  has_one_attached :published_video, service: :cloudinary_compiled_videos

  # override
  def title
    if event.birthday?
      "#{reference.short_name}'s Birthday!"
    elsif event.work_anniversary?
      "#{reference.short_name}'s Workiversary!"
    else
      super
    end
  end

  def slug
    "#{event.name} #{id}".parameterize
  end

  def upload_folder
    slug
  end
end
  