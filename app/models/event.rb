class Event < ApplicationRecord
  belongs_to :creator, polymorphic: true

  scope :system_generated, -> { where(system_generated: true) }
end
