class Genre < ApplicationRecord
  has_many :categorizations, dependent: :destroy
  has_many :movies, through: :categorizations

  validates :name, presence: true, uniqueness: true
end
