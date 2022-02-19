class Label < ApplicationRecord
  has_many :labelings, dependent: :destroy
  has_many :tasks, through: :labelings
  validates :label_name, presence: true, length: {maximum: 50}
end
