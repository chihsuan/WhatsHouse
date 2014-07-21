class UsersController < ApplicationController
	before_action :signed_in_user, only: [:show, :edit, :update]	
	before_action :correct_user,   only: [:show, :edit, :update]		

	# sign_up
	def new
		@user = User.new
	end

	# create new user
	def create
		@user = User.new(user_params)
		if @user.save
			sign_in @user
			flash[:success] = "註冊成功!"
			UserMailer.confirm(@user.email).deliver
			redirect_to @user
		else
			render :new
		end
	end

	def show
	end

	def edit
	end

	# upadet user profile
	def update	
		if @user.update_attributes(user_params)
			flash[:success] = "更新成功!"
			redirect_to @user
		else
			render :edit
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

	protected

end
