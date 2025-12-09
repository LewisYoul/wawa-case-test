class ChatRoomsController < ApplicationController
  layout "chat_rooms"
  before_action :set_chat_rooms, only: :index

  def index
  end

  # TODO: display a nice toast when there's an error
  def create
    ChatRoom.create!(chat_room_params)

    set_chat_rooms

    respond_to do |format|
      format.html { render :index }
    end
  rescue StandardError => e
    set_chat_rooms

    respond_to do |format|
      format.html { render :index, status: :unprocessable_entity }
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