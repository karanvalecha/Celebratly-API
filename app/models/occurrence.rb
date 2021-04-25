class Occurrence < ApplicationRecord
  belongs_to :event

  has_one :reference, through: :event
  has_many :status_uploads

  def slug
    "#{event.name} #{id}".parameterize
  end

  def upload_folder
    slug
  end
end
  