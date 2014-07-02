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
			
		if params[:rating] && !params[:rating].empty?
			@score_list = []
			for house in @data
				@tmp = 0
				for i in 0...params[:rating].length
					@tmp = @tmp + house['around_list'][i].to_i * params[:rating][i].to_i
				end
				@score_list << @tmp
			end
			@data = [@data] + [ @score_list.map.with_index.sort_by(&:first).map(&:last) ]
		else
			@data = [@data] + [ " " ]
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
		else
      		render 'sale'
		end

	end

	def create
    	@sale_house = current_user.sale_houses.build(saleHouses_params)
      	@sale_house.img = params[:img].join(',')
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
