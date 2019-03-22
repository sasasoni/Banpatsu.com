class User < ApplicationRecord
  attr_accessor :remember_token

  before_save { email.downcase! }
  validates :name, presence: true, length: { maximum: 50 },
    uniqueness: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :circle_name, presence: true, length: { maximum: 50 }
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  VALID_URL_REGEX = /\Ahttps?:\/\/(www\.)?[\w\-]+\.[\w\.\/\-]+\z/i
  validates :site_url, format: { with: VALID_URL_REGEX },
    allow_nil: true
    # unless: Proc.new { |u| u.site_url.blank? }
    # allow_nil -> 空白時の例外処理

  has_secure_password

  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST : BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end