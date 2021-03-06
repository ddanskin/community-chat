class ChatRoomsController < ApplicationController
    def index
        @chat_rooms = ChatRoom.all
        @users = User.all
        @connection = Connection.new
        @connections = Connection.where(other_user_id: current_user.id, status: "pending")
        @requests = Connection.where(user_id: current_user.id, status: "pending")
        @private_chat_room = PrivateChatRoom.new
        @private_chat_rooms = PrivateChatRoom.all
    end

    def new
        @chat_room = ChatRoom.new
    end

    def create
        @chat_room = current_user.chat_rooms.build(chat_room_params)
        if @chat_room.save
            flash[:success] = 'Chat room added!'
            redirect_to chat_rooms_path
        else
            render 'new'
        end
    end

    def show
        @chat_room = ChatRoom.includes(:messages).find_by(id: params[:id])
        @message = Message.new
    end

    private

    def chat_room_params
        params.require(:chat_room).permit(:title)
    end
end
