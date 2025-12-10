class ChatRoom < ApplicationRecord
  has_many :users

  validates :name, presence: true, uniqueness: true
  # TODO: Add validation
end