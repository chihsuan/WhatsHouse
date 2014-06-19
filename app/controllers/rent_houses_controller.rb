class RentHousesController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
	before_action :correct_user,   only: :destroy


	def rent
		if signed_in?
			@user = current_user
			@rent_house = current_user.rent_houses.build
			@rent_houses = current_user.rent_houses.paginate(page: params[:page])
		end
	end

	def create
    	@rent_house = current_user.rent_houses.build(rentHouses_params)
    	if @rent_house.save
     	 	flash[:success] = "RentHouse created!"
      		redirect_to renthouse_path
    	else
      		render '/'
    	end
 	 end

  	def destroy
 		@rent_house.destroy
  		redirect_to renthouse_path
  	end


  private


    def rentHouses_params
      params.require(:rent_house).permit(:use, :address, :price, :size, :owner,
      									 :structure, :year, :floor, :breif, :note, :tel, :name, :email )
    end
	
	def correct_user
      @rent_house = current_user.rent_houses.find_by(id: params[:id])
      redirect_to root_url if @rent_house.nil?
    end
end
