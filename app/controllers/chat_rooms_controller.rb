class ChatRoomsController < ApplicationController
  before_action :access_to_chat, only: [:show]

  def index
    @chat_rooms = ChatRoom.all
    @chat_rooms_for_user = ChatRoom.where(chat_to_user: current_user.id)
  end

  def show
    @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
    @message = Message.new
  end

  def new
    @chat_to_user = params['id']
    @chat_room = ChatRoom.new
  end

  def create
    @chat_to_user = params['chat_to_user']
    @chat_room = current_user.chat_rooms.build(chat_room_params)
    if @chat_room.save
      flash[:success] = 'Chat room added!'
      redirect_to chat_rooms_path
    else
      render 'new'
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title, 'chat_to_user')
  end

  def access_to_chat
    unless current_user.chat_rooms.where("id=?", params[:id]).any? || ChatRoom.where(chat_to_user: current_user.id).where("id=?", params[:id]).any? || current_user.admin?
      redirect_to root_path
      flash[:danger]="У вас нет доступа к данному чату"
    end
  end

end
