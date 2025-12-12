class MessagesController < ApplicationController
  def create
    respond_to do |format|
      format.turbo_stream do
        # Potential for to_i to throw here, should probably use safe navigation operator
        @chat_room = ChatRoom.find_by(id: params[:chat_room_id].to_i)

        # TODO: render a flash message
        return head :not_found unless @chat_room

        params = message_params.merge(user: Current.user, chat_room: @chat_room)

        result = Messages::Creator.call(params)

        if !result.success?
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