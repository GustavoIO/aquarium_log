class Aquarium < ApplicationRecord
  has_many :measurements, dependent: :destroy

  validates :name, presence: true
end
