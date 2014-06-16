class RentHousesController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]

	def rent
		if signed_in?
			@rent_house = current_user.rent_houses.build
		end
	end

	def create
    	@rent_house = current_user.rent_houses.build(rentHouses_params)
    	if @rent_house.save
     	 	flash[:success] = "RentHouse created!"
      		redirect_to root_url
    	else
      		render '/'
    	end
 	 end

  	def destroy
 		@rent_house.destroy
  		redirect_to root_url
  	end

  private

    def rentHouses_params
      params.require(:rent_house).permit(:address)
    end

end
