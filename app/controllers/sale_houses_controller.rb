class SaleHousesController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]

	def sale
		if signed_in?
			@sale_house = current_user.sale_houses.build
		end
	end

	def create
    	@sale_house = current_user.sale_houses.build(saleHouses_params)
    	if @sale_house.save
     	 	flash[:success] = "SaleHouse created!"
      		redirect_to root_url
    	else
      		render '/'
    	end
 	 end

  	def destroy
 		@sale_house.destroy
  		redirect_to root_url
  	end

  private

    def saleHouses_params
      params.require(:sale_house).permit(:address)
    end

end
