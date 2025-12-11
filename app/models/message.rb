class Message < ApplicationRecord
  belongs_to :chat_room
  belongs_to :user

  validates :content, presence: true

  after_create_commit -> {
    broadcast_append_to chat_room, partial: "messages/message", locals: { message: self }
  }
end