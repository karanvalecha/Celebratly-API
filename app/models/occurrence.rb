class Occurrence < ApplicationRecord
  belongs_to :event

  has_one :reference, through: :event

  def slug
    "#{event.name} #{id}".parameterize
  end

  def upload_folder
    slug
  end
end
  