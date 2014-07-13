class PasswordResetsController < ApplicationController
  	
	def new
  	end

	# find user in database and send pasword_reset email to user
  	def create
 	 	user = User.find_by_email(params[:email])
  		if user
  			user.send_password_reset 
  			redirect_to root_url, :notice => "重設密碼信件已寄送至使用者信箱"
		else
			redirect_to new_password_reset_path, :notice => "錯誤，使用者並不存在!"
		end
  	end

 	def edit
  		@user = User.find_by_password_reset_token!(params[:id])
  	end

	# user update password if time is within 2 hours
  	def update
		@user = User.find_by_password_reset_token!(params[:id])
  		if @user.password_reset_sent_at < 2.hours.ago
    		redirect_to new_password_reset_path, :alert => "Password &crarr; 
      		reset has expired."
  		elsif @user.update_attributes(user_update_params)
    		redirect_to root_url, :notice => "密碼已重設"
  		else
    		render :edit
  		end
	end

	private

	  def user_update_params
    	params.require(:user).permit(:password,
      	                           :password_confirmation)
   	  end
end
