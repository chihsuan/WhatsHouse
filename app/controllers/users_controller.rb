class UsersController < ApplicationController
  	before_action :signed_in_user, only: [:edit, :update]	
  	before_action :correct_user,   only: [:edit, :update]		
	# sign up controller


	def show
  		@user = User.find(params[:id])
  	end

	# new user for sign up form
 	def new
		@user = User.new
 	end
	
	# create new user by user input
	def create
    	@user = User.new(user_params)
   		if @user.save
   			UserMailer.confirm(@user.email).deliver
     	 	sign_in @user
     	 	flash[:success] = "註冊成功!"
      		redirect_to @user
    	else
      		render 'new'
    	end
  	end

	def edit
	end

	# upadet user profile
	def update	
  	  	@user = User.find(params[:id])
    	if @user.update_attributes(user_params)
      	flash[:success] = "更新成功!"
      	redirect_to @user
    	else
      	 render 'edit'
   		end
  	end
	

  	private

    def user_params
    	params.require(:user).permit(:name, :email, :password,
      	                           :password_confirmation)
    end

  	def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
