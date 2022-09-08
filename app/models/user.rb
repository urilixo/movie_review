class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :username, presence: true, uniqueness: {case_sensitive: false}
  validates :email, format: {with: /\S+@\S+/ }, uniqueness: { case_sensitive: false}

  def gravatar_id
    Digest::MD5::hexdigest(email.downcase)
  end
end
