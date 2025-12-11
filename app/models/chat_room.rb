class ChatRoom < ApplicationRecord
  has_many :users
  has_many :messages

  validates :name, presence: true, uniqueness: true
  # TODO: Add validation
end