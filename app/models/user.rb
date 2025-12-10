class User < ApplicationRecord
  has_secure_password
  has_many :sessions, dependent: :destroy
  belongs_to :chat_room, optional: true

  normalizes :email_address, with: ->(e) { e.strip.downcase }

  validates :username, presence: true, uniqueness: true
  validates :email_address, presence: true, uniqueness: true
end
