class Event < ApplicationRecord
  attr_accessor :no_expiration
  before_validation { self.end_date = nil if self.no_expiration == '1' }

  belongs_to :user
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :title, presence: true
  validates :description, presence: true, length: { maximum: 1000 }
  validates :start_date, presence: true

  scope :new_events, -> { take(5) }
  scope :calendar, -> (first_date, last_date) do
    where("start_date >= ? AND start_date <= ?", first_date, last_date)
  end
  scope :nearest, -> do
    now = Time.current
    where("start_date >= ?", now).order(:start_date)
  end

  def self.search(query)
    rel = order(created_at: :desc)
    # present? => !blank?
    if query.present?
      user_ids = "SELECT id FROM users WHERE circle_name LIKE :query"
      rel = rel.where(
        "user_id IN (#{user_ids}) OR title LIKE :query", query: "%#{query}%")
    end
    rel
  end
end
