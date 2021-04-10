class Event < ApplicationRecord
  belongs_to :creator, polymorphic: true
  has_many_attached :posts

  scope :system_generated, -> { where(system_generated: true) }
end
