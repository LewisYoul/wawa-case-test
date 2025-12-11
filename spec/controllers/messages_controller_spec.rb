require 'rails_helper'

RSpec.describe MessagesController, type: :controller do
  let(:user) { User.create!(username: "test", email_address: "test@example.com", password: "password") }
  let(:session) { user.sessions.create!(user_agent: "Test", ip_address: "127.0.0.1") }

  before do
    cookies.signed[:session_id] = session.id
  end

  describe "#create" do
    context "the params are valid" do
      it "creates a new message with the expected content" do
        chat_room = ChatRoom.create!(name: "Test")

        expect { post(:create, params: { chat_room_id: chat_room.id, message: { content: "Hello" } }, format: :turbo_stream) }
          .to change { chat_room.messages.count }.from(0).to(1)

        expect(chat_room.messages.last.content).to eq("Hello")
        expect(chat_room.messages.last.user).to eq(user)
        expect(response).to have_http_status(:success)
      end
    end

    context "the chat room doesn't exist" do
      it "doesn't create a new message" do
        expect { post(:create, params: { chat_room_id: 999, message: { content: "Hello" } }, format: :turbo_stream) }
          .not_to change { Message.count }.from(0)

        expect(response).to have_http_status(:not_found)
      end
    end

    context "there is no content" do
      it "doesn't create a new message" do
        chat_room = ChatRoom.create!(name: "Test")

        expect { post(:create, params: { chat_room_id: chat_room.id, message: { content: nil } }, format: :turbo_stream) }
          .not_to change { Message.count }.from(0)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
