class SessionsController < ApplicationController
	
	#sign in and sign out controller, create remember token to cookie

	def new
	end
	
	def create
    	user = User.find_by(email: params[:session][:email].downcase)
    	if user && user.authenticate(params[:session][:password])
      		sign_in user
    		redirect_back_or rent_path
    	elsif user
			flash.now[:error] = "密碼輸入錯誤"
    		render :new
    	else
        	flash.now[:error] = '不存在使用者email'
    		render :new
    	end
 	end 

	# facebook sign in
	def facebook
		auth_hash = request.env['omniauth.auth']
		@authorization = Authorization.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"] )
		if @authorization
    		user = User.find(@authorization.user_id)
        else
        	user = User.new :name => auth_hash["info"]["name"], :email => auth_hash["info"]["email"], :password => User.new_remember_token
			user.authorizations.build :provider => auth_hash["provider"], :uid => auth_hash["uid"]
			user.save!
        end
      	sign_in user
    	redirect_back_or rent_path
	end

	# sign out
	def destroy
		sign_out
		redirect_to root_path
	end

	def failure
		render :text => "Sorry, but you didn't allow access to our app!"
	end
end
