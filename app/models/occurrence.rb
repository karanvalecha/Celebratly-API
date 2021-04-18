class Occurrence < ApplicationRecord
  belongs_to :event

  has_one :reference, through: :event
end
  