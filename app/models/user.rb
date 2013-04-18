class User < ActiveRecord::Base
  include BCrypt
  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :birthdate

  valid_email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, uniqueness: true, format: { with: valid_email_regex }
  validates :password, presence: true, confirmation: true

  has_many :events
  has_many :event_users
  has_many :attended_events,  through: :event_users, source: :event        
  has_many :created_events, class_name: 'Event'

  def password
    puts password_hash
    @password ||= Password.new(self.password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
