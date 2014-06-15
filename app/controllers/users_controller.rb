class UsersController < ApplicationController
  def show
  	@user = User.find(params[:id])
  end

  def create
	@user = User.new(params[:user])    # Not the final implementation!
    if @user.save
    	flash[:success] = "Welcome to the WhatsHouse!"
    	redirect_to @user
    else
     	render 'new'
    end	
  end 

  private:

  def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  end
end
