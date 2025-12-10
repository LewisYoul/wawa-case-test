class AddChatRoomToUsers < ActiveRecord::Migration[8.1]
  def change
    add_reference :users, :chat_room, foreign_key: true
  end
end
