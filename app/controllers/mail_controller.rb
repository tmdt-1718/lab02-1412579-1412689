class MailController < ApplicationController
    before_action :isLogin
    def new
        id = session[:current_user]["id"];
        @added_fr = Friend.where("user_id = #{id}").where("ban is null")
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
            mail = Mail.new(:user_send => session[:current_user]["id"], :user_receive => id,:title => mail_params[:title],:content => mail_params[:content])
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

    end
    def received
        
    end
    def read
    end
    private
    def mail_params
		params.require(:mail).permit(:title,:content,:id => [])
    end
end
