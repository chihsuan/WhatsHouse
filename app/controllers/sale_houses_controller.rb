class SaleHousesController < ApplicationController
	
	before_action :signed_in_user, only: [:create, :destroy]
	before_action :correct_user,   only: :destroy


	def show
		@district = params[:district]
		if !params[:price] && !params[:district]  
    		@data = SaleHouse.where("address like ?", "%#{@district}%").where(:price => params[:price].split(" ")[0]...params[:price].split(" ")[1]) 
		elsif params[:price] 
    		@data = SaleHouse.where(:price => params[:price].split(" ")[0]...params[:price].split(" ")[1]) 
		else
    		@data = SaleHouse.where("address like ?", "%#{@district}%")
		end
		
		respond_to do |format|
			format.json { render :json => @data }
		end
	end



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
      		redirect_to salehouse_path
    	else
      		render '/'
    	end
 	 end

  	def destroy
 		@sale_house.destroy
  		redirect_to salehouse_path
  	end

  private

    def saleHouses_params
      params.require(:sale_house).permit(:use, :address, :price, :size, :owner,
      									 :structure, :year, :floor, :breif, :note, :tel, :name, :email, :district )
    end

	
	def correct_user
      @sale_house = current_user.sale_houses.find_by(id: params[:id])
      redirect_to root_url if @sale_house.nil?
    end
end
