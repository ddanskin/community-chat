class ConnectionsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_connection, only: [:show, :edit, :update, :destroy]

    def new
        @connection = Connection.new
    end

    def create
        @connection = Connection.create(connection_params)
        if @connection.save
            @user = User.find(@connection[:other_user_id])
            flash[:notice] = "#{@user.name} was requested"
            redirect_to(chat_rooms_path)
        else
            render('new')
        end
    end

    def edit

    end

    def update
        @connection.update_attributes(connection_params)
        redirect_to(chat_rooms_path)
    end

    def delete
    end

    def destroy
        @connection.destroy
        flash[:notice] = "Connection was rejected"
        redirect_to(chat_rooms_path)
    end

    private
        def set_connection
            @connection = Connection.find(params[:id])
        end
        def connection_params
            params.require(:connection).permit(:user_id, :other_user_id, :status)
        end
end
