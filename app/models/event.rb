class Event < ActiveRecord::Base
  belongs_to :user
  has_many :event_users
  has_many :users, through: :event_users

  validates :name, presence: true
  validates :location, presence: true
  validates :starts_at, presence: true
  validates :ends_at, presence: true
end
