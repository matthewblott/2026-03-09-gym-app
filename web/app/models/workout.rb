class Workout < ApplicationRecord
  has_many :exercises, dependent: :destroy

  validates :created_at, presence: true
end
