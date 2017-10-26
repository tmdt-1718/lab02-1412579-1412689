class FriendController < ApplicationController
    before_action :isLogin
    def list
      @user=User.all
        id = session[:current_user]["id"];
        @added_fr = Friend.where("user_id = #{id}").where("ban = 0")
        @array = []
        @added_fr.each do |us|
            @array.push(us.friend_id)
        end

        @banned = Friend.where("user_id = #{id}").where("ban = 1")

        array_banned = []
        @banned.each do |us|
            array_banned.push(us.friend_id)
        end
        if array_banned.any?
            @user = User.where("id != (?)", id).where('id not in (?)',array_banned)
        else
            @user = User.where("id != (?)", id)
        end

        if @user.empty?
        else

        end
    end
    def banned
        id = session[:current_user]["id"];


        @banned = Friend.where("user_id = #{id}").where("ban = 1")
        array_banned = []
        @banned.each do |us|
            array_banned.push(us.friend_id)
        end

            @user = User.where('id in (?)',array_banned)

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
            friend_to = Friend.new(friend_id: session[:current_user]["id"], user_id: params[:id])
            if friend.save && friend_to.save
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
            friend_del = Friend.where(friend_id: session[:current_user]["id"], user_id: params[:id]).first
            p friend
            des = Friend.destroy(friend.id)
            des_to = Friend.destroy(friend_del.id)
            if des.destroyed? && des_to.destroyed?
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
    def ban
        if request.xhr?
            friend = Friend.where(user_id: session[:current_user]["id"], friend_id: params[:id]).first
            friend_to = Friend.where(friend_id: session[:current_user]["id"], user_id: params[:id]).first
            p friend
            friend.ban = 1
            friend_to.ban = 1
            if friend.save && friend_to.save
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
    def unban
        if request.xhr?
            friend = Friend.where(user_id: session[:current_user]["id"], friend_id: params[:id]).first
            friend_to = Friend.where(friend_id: session[:current_user]["id"], user_id: params[:id]).first
            p friend
            friend.ban = 0
            friend_to.ban = 0
            if friend.save && friend_to.save
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
