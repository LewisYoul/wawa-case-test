RSpec.describe Message, type: :model do
  it "must have content" do
    user = User.create!(username: "test", email_address: "test@example.com", password: "password")
    chat_room = ChatRoom.create!(name: "Test")
    message = Message.new(content: nil, user: user, chat_room: chat_room)
    message.save
    
    expect(message).to be_invalid
    expect(message.errors.full_messages).to include("Content can't be blank")
  end

  it "must have a chat room" do
    user = User.create!(username: "test", email_address: "test@example.com", password: "password")
    message = Message.new(content: "Hello", user: user, chat_room: nil)
    message.save
    
    expect(message).to be_invalid
    expect(message.errors.full_messages).to include("Chat room must exist")
  end

  it "must have a user" do
    chat_room = ChatRoom.create!(name: "Test")
    message = Message.new(content: "Hello", user: nil, chat_room: chat_room)
    message.save
    
    expect(message).to be_invalid
    expect(message.errors.full_messages).to include("User must exist")
  end
end