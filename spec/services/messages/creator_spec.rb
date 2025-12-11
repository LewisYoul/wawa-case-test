RSpec.describe Messages::Creator do
  describe "#call" do

  let(:chat_room) { ChatRoom.create!(name: "Test") }
  let(:user) { User.create!(username: "test", email_address: "test@example.com", password: "password") }

    context "the params are valid" do
      let(:params) { { content: "Hello, world!", user: user, chat_room: chat_room } }
      it "creates a new message" do
        expect { Messages::Creator.call(params) }
          .to change { chat_room.messages.count }.from(0).to(1)
          .and change { user.messages.count }.from(0).to(1)
      end

      it "sends a broadcast to the chat room" do
        message = instance_double(Message, save: true, broadcast_append_to: true, chat_room: chat_room)

        allow(Message).to receive(:new).and_return(message)
        expect(message).to receive(:broadcast_append_to).with(chat_room, partial: "messages/message", locals: { message: message })

        Messages::Creator.call(params)
      end

      it "returns a success result" do
        result = Messages::Creator.call(params)

        expect(result.success?).to eq(true)
        expect(result.message).to be_an_instance_of(Message)
      end
    end

    context "the params are invalid" do
      let(:params) { { content: "", user: user, chat_room: chat_room } }

      it "does not create a new message" do
        expect { Messages::Creator.call(params) }
          .to not_change { chat_room.messages.count }
          .and not_change { user.messages.count }
      end

      it "does not send a broadcast to the chat room" do
        message = instance_double(Message, save: false, broadcast_append_to: true, chat_room: chat_room)

        allow(Message).to receive(:new).and_return(message)

        expect(message).not_to receive(:broadcast_append_to)

        Messages::Creator.call(params)
      end
      
      it "returns a failure result" do
        result = Messages::Creator.call(params)

        expect(result.success?).to eq(false)
        expect(result.message).to be_an_instance_of(Message)
      end
    end
  end
end