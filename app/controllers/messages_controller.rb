class MessagesController < ApplicationController
  def create
    respond_to do |format|
      format.turbo_stream do
        @chat_room = ChatRoom.find_by(id: params[:chat_room_id].to_i)

        # TODO: render a flash message
        return head :not_found unless @chat_room

        begin
          @message = @chat_room.messages.create!(message_params.merge(user: Current.user))
        rescue ActiveRecord::RecordInvalid => e
          # TODO: render a flash message
          return head :unprocessable_entity
        end
      end
    end
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end