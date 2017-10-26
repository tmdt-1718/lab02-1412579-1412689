class MessController < ApplicationController
    before_action :isLogin, only:[ :new, :pnew, :sent, :received, :read, :show]
    def new
        id = session[:current_user]["id"];
      
        @added_fr = Friend.where("user_id = #{id}").where("ban = 0")

        array = []
        @added_fr.each do |us|
            array.push(us.friend_id)
        end
        @user = User.where("id != (?)", id).where('id in (?)',array)
        if @user.empty?
        else

        end
    end
    def pnew
        flag = 0
        mail_params[:id].each do |id,index|
            mail = Mess.new(:user_send => session[:current_user]["id"], :user_receive => id,:title => mail_params[:title],:content => mail_params[:content])
            mail.save
            if mail.errors
                puts mail.errors.full_messages
            end
            if mail.persisted?
                flag = flag + 1
            end
        end
        if flag == mail_params[:id].length
            flash[:success] = "Đã gửi tin nhắn thành công!"
            redirect_to :sent
        else
            flash[:error] = "Gửi tin nhắn thất bại, vui lòng thử lại sau!"
            redirect_to :sent
        end
    end
    def sent

      @mail = Mess.joins("INNER JOIN users ON users.id = messes.user_receive").where(:user_send => session[:current_user]["id"]).select("messes.*","users.fullname")
    end
    def received
      @mail = Mess.joins("INNER JOIN users ON users.id = messes.user_send").where(:user_receive => session[:current_user]["id"]).where(:isRead => nil).select("messes.*","users.fullname")

    end
    def readsent
      @ml = Mess.find_by_id(params[:id])
      @email = User.find_by_id(@ml.user_receive)
    end
    def readreceived
        @ml = Mess.find_by_id(params[:id])
        @email = User.find_by_id(@ml.user_receive)
        if @ml.user_receive == session[:current_user]["id"]
            @ml.isRead = 1
            @ml.save
        else
            redirect_to :received
        end
    end
    private
    def mail_params
		params.require(:mail).permit(:title,:content,:id => [])
    end
    private
    def mail_params
		params.require(:mail).permit(:title,:content,:id => [])
    end
end
