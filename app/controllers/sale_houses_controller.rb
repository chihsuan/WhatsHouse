class SaleHousesController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
	before_action :correct_user,   only: :destroy
	
	def sale
		if signed_in?
			@user = current_user
			@sale_house = current_user.sale_houses.build
			@sale_houses = current_user.sale_houses.paginate(page: params[:page])
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

	
	def correct_user
      @sale_house = current_user.sale_houses.find_by(id: params[:id])
      redirect_to root_url if @sale_house.nil?
    end
end
