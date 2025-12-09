class ChatRoom < ApplicationRecord
  validates :name, presence: true, uniqueness: true
end