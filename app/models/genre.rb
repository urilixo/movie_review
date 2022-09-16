class Genre < ApplicationRecord
  before_save :set_slug

  has_many :categorizations, dependent: :destroy
  has_many :movies, through: :categorizations

  validates :name, presence: true, uniqueness: true

  def set_slug
    self.slug = name.parameterize
  end

  def to_param
    slug
  end
end
