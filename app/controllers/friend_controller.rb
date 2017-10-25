class FriendController < ApplicationController
    before_action :isLogin
    def list
      @user=User.all
        id = session[:current_user]["id"];
        @added_fr = Friend.where("user_id = #{id}").where("ban is null")
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
    def ban
        if request.xhr?
            friend = Friend.where(user_id: session[:current_user]["id"], friend_id: params[:id]).first
            p friend
            friend.ban = 1
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
    def unban
        if request.xhr?
            friend = Friend.where(user_id: session[:current_user]["id"], friend_id: params[:id]).first
            p friend
            friend.ban = nil
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
end
