class Measurement < ApplicationRecord
  belongs_to :aquarium

  validates :measured_at, presence: true
  validates :ph, numericality: { greater_than: 0, less_than: 14, allow_nil: true }
  validates :kh, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :gh, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :nitrates, numericality: { greater_than_or_equal_to: 0, allow_nil: true }
  validates :phosphates, numericality: { greater_than_or_equal_to: 0, allow_nil: true }

  default_scope { order(measured_at: :desc) }
end
