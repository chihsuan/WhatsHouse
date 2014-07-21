class RentHousesController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy, :update, :edit]
	before_action :correct_user,   only: :destroy

	def show
  		if signed_in?
  			@rentHouse = RentHouse.find(params[:id])
  		else 
  			redirect_to '/signin'
		end
	end

	def edit
		@rent_house = RentHouse.find(params[:id])
	end

	# upadet user profile
	def update
		@current_houses = RentHouse.find(params[:id])
    	if @current_houses.update_attributes(rentHouses_params)
      	  flash[:success] = "更新成功!"
      	  redirect_to @current_houses
    	else
      	  render :edit
   		end
  	end
	

	def new
		if signed_in?
			@user = current_user
			@rent_house = current_user.rent_houses.build
			@rent_houses = current_user.rent_houses.paginate(page: params[:page])
		else
      		redirect_to '/signin'
		end
	end

	def create
    	begin
    		@rent_house = current_user.rent_houses.build(rentHouses_params)
      		@rent_house.img = params[:img].join(',')
   	 		if @rent_house.save
     		 	flash[:success] = "RentHouse created!"
      			redirect_to rent_path
    		else
    			@user = current_user
      			render :new
    		end
    	rescue Exception => ex
    		flash[:error] = "#{ex}"
			render :new
		end
	end

  	def destroy
 			@rent_house.destroy
  		redirect_to renthouse_path
  	end


  private


    def rentHouses_params
    	params.require(:rent_house).permit(:use, :address, :price, :size, :owner,
      									 :structure, :year, :information, :tel, :name, :email, :district, :around_list, :img, :people)
    
    end
	
	def correct_user
		@rent_house = current_user.rent_houses.find_by(id: params[:id])
		redirect_to root_url if @rent_house.nil?
    end
end
