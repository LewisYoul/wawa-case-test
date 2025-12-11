class ChatRoomsController < ApplicationController
  layout "chat_rooms"
  before_action :set_chat_rooms, only: :index

  def index
  end

  # TODO: display a nice toast when there's an error
  def create
    respond_to do |format|
      format.html do
        ChatRoom.create!(chat_room_params)

        set_chat_rooms

        render :index
      rescue ActiveRecord::RecordInvalid => e
        set_chat_rooms

        render :index, status: :unprocessable_entity
      end
    end
  end

  def show
    respond_to do |format|
      format.html do
        @chat_room = ChatRoom.find_by(id: params[:id])

        return redirect_to chat_rooms_path unless @chat_room

        Current.user.update!(chat_room: @chat_room)

        @messages = @chat_room.messages.includes(:user).order(created_at: :asc)
      end
    end
  end

  def leave
    respond_to do |format|
      format.html do
        @chat_room = ChatRoom.find_by(id: params[:id])

        return redirect_to chat_rooms_path unless @chat_room

        Current.user.update!(chat_room: nil)

        redirect_to chat_rooms_path
      end
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:name)
  end

  def set_chat_rooms
    @chat_rooms = ChatRoom.order(created_at: :desc)
  end
end