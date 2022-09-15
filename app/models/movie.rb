class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user
  has_many :reviewers, through: :reviews, source: :user
  has_many :categorizations, dependent: :destroy
  has_many :genres, through: :categorizations

  RATINGS = %w[G PG PG-13 R NC-17]
  validates :title, :released_on, :duration, presence: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  validates :image_file_name, format: {
    with: /\w+\.(jpg|png)\z/i,
    message: 'must be a JPG or PNG image'
  }
  validates :rating, inclusion: { in: RATINGS }

  scope :released, -> { where('released_on < ?', Time.now).order('released_on desc') }
  scope :flop, -> { where('total_gross <= ?', 225_000_000) }
  scope :hit, -> { where('total_gross >= ?', 300_000_000) }
  scope :upcoming, -> { where('released_on > ?', Time.now).order('released_on asc') }
  scope :recently_added, ->(max = 5) { released.limit(max) }

  def flop?
    total_gross.blank? || total_gross < 250_000_000
  end

  def average_stars_as_percent
    ((reviews.average(:stars) || 0.0) / 5.0) * 100 || 0.0
  end

  def reviews_amount
    reviews.count || 0.0
  end
end
