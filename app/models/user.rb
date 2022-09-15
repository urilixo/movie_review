class User < ApplicationRecord
  has_secure_password

  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :favorited, through: :favorites, source: :movie
  has_many :reviewed, through: :reviews, source: :movie

  validates :name, presence: true
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :email, format: { with: /\S+@\S+/ }, uniqueness: { case_sensitive: false }

  scope :by_name, -> { order(:name) }
  scope :normal_users, -> {where(admin: false)}
  scope :admin_users, -> { where(admin: true) }

  def gravatar_id
    Digest::MD5.hexdigest(email.downcase)
  end
end
