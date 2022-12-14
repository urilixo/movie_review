class Movie < ApplicationRecord
  before_save :set_slug

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :fans, through: :favorites, source: :user
  has_many :reviewers, through: :reviews, source: :user
  has_many :categorizations, dependent: :destroy
  has_many :genres, through: :categorizations

  has_one_attached :cover_image

  RATINGS = %w[G PG PG-13 R NC-17]
  FILTERS = ['Released movies', 'Upcoming movies', 'Hit movies', 'Flopped movies', 'Recently added']
  validates :title, presence: true, uniqueness: true
  validates :released_on, :duration, presence: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  validates :rating, inclusion: { in: RATINGS }
  validate :acceptable_image

  scope :released, -> { where('released_on < ?', Time.now).order('released_on desc') }
  scope :flopped, -> { where('total_gross <= ?', 225_000_000) }
  scope :hit, -> { where('total_gross >= ?', 300_000_000) }
  scope :upcoming, -> { where('released_on > ?', Time.now).order('released_on asc') }
  scope :recently, ->(max = 5) { released.limit(max) }

  def flop?
    total_gross.blank? || total_gross < 250_000_000
  end

  def average_stars_as_percent
    ((reviews.average(:stars) || 0.0) / 5.0) * 100 || 0.0
  end

  def reviews_amount
    reviews.count || 0.0
  end

  def to_param
    slug
  end

  def set_slug
    self.slug = title.parameterize
  end

  def acceptable_image
    return unless cover_image.attached?

    errors.add(:cover_image, 'is too big') unless cover_image.blob.byte_size <= 1.megabyte

    acceptable_types = ['image/jpeg', 'image/png']
    errors.add(:cover_image, 'must be a JPEG or PNG') unless acceptable_types.include?(cover_image.content_type)
  end
end
