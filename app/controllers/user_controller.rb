class UserController < ApplicationController
    require 'bcrypt'
    before_action :isLoged, only: [:login,:signup]
    def login
        @user = User.new
    end
    def signup
        @user = User.new
    end
    def plogin
        user = User.find_by(email: session_params[:email])
        #p user.password_digest
        if user && BCrypt::Password.new(user.password_digest) == session_params[:password]
            loginTo(user)
            redirect_to :index
        else
            flash[:error] = "Thông tin đăng nhập không chính xác!"
            redirect_to :login
        end
    end
    def psignup
        user = User.find_by(email: user_params[:email])
        if user
            flash[:error] = "Tên tài khoản đã tồn tại!"
            render :action => :signup
        else
            @user = User.new(user_params);
            if @user.save
                flash[:success] = "Tài khoản #{@user.email} đã đăng ký thành công!"
                redirect_to login_path
            else
                render :action => :signup
            end
        end
    end
    def session_params
		params.require(:session).permit(:email,:password)
    end
    def logout
        session.delete(:current_user)
        redirect_to :index
    end
    def user_params
		params.require(:user).permit(:fullname,:email,:password,:password_confirmation)
	end
end
