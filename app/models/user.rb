class User < ApplicationRecord
  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 50 },
    uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :circle_name, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }
  VALID_URL_REGEX = /\Ahttps?:\/\/(www\.)?[\w\-]+\.[\w\.\/\-]+\z/i
  validates :site_url, format: { with: VALID_URL_REGEX },
    unless: Proc.new { |u| u.site_url.blank? }

  has_secure_password

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
end