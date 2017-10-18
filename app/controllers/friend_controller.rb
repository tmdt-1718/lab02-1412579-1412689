class FriendController < ApplicationController
    def list
        id = session[:current_user]["id"];
        @added_fr = Friend.where("user_id = #{id}")
        @array = []
        @added_fr.each do |us|
            @array.push(us.friend_id)
        end
        @user = User.where("id != (?)", id)
        if @user.empty?
        else
            
        end
    end
    def added
        id = session[:current_user]["id"];
        added_fr = Friend.where("user_id = #{id}")
        array = []
        added_fr.each do |us|
            array.push(us.friend_id)
        end
        @user = User.where("id in (?)", array)
        if @user.empty?

        else
            
        end
    end 
    def add
        if request.xhr?
            friend = Friend.new(user_id: session[:current_user]["id"], friend_id: params[:id])
            if friend.save
                render :json => {
                    :status => 1
                }
            else
                render :json => {
                    :status => 0
                }
            end
        end
    end
    def destroy
        if request.xhr?
            friend = Friend.where(user_id: session[:current_user]["id"], friend_id: params[:id]).first
            p friend
            des = Friend.destroy(friend.id)
            if des.destroyed?
                render :json => {
                    :status => 1
                }
            else
                render :json => {
                    :status => 0
                }
            end
        end
    end
end
