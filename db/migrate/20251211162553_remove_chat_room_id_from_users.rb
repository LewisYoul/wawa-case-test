class RemoveChatRoomIdFromUsers < ActiveRecord::Migration[8.1]
  def change
    remove_reference :users, :chat_room, foreign_key: true
  end
end
