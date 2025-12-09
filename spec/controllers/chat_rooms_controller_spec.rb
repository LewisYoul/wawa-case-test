require 'rails_helper'

RSpec.describe ChatRoomsController, type: :controller do
  describe "#create" do
    let(:user) { User.create!(username: "test", email_address: "test@example.com", password: "password") }
    let(:session) { user.sessions.create!(user_agent: "Test", ip_address: "127.0.0.1") }

    before do
      cookies.signed[:session_id] = session.id
    end

    context "the params are valid" do
      it "creates a new chat room with the expected name" do
        expect { post(:create, params: { chat_room: { name: "Test" } }) }
          .to change { ChatRoom.count }.from(0).to(1)

        expect(ChatRoom.last.name).to eq("Test")
        # expect(response).to render_template(:index)
        expect(response).to have_http_status(:success)
      end
    end

    context "the params are invalid" do
      it "doesn't create a new chat room when the name is missing" do
        expect { post(:create, params: { chat_room: { name: nil } }) }
          .not_to change { ChatRoom.count }.from(0)

        # expect(response).to render_template(:index)
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "doesn't create a new chat room when the name is already taken" do
        ChatRoom.create!(name: "Test")

        expect { post(:create, params: { chat_room: { name: "Test" } }) }
          .not_to change { ChatRoom.count }.from(1)

        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end