class RentHousesController < ApplicationController
	before_action :signed_in_user, only: [:create, :destroy]
	before_action :correct_user,   only: :destroy


	def show
		@district = params[:district]
		if !params[:price] && !params[:district]
    		@data = RentHouse.where("address like ?", "%#{@district}%").where(:price => params[:price].split(" ")[0]...params[:price].split(" ")[1]) 
		elsif params[:price]
    		@data = RentHouse.where(:price => params[:price].split(" ")[0]...params[:price].split(" ")[1]) 
		else
    		@data = RentHouse.where("address like ?", "%#{@district}%")
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
			@data = [@data] + [" "]
		end
	
		respond_to do |format|
			format.json { render :json => @data }
		end
	end

	def rent
		if signed_in?
			@user = current_user
			@rent_house = current_user.rent_houses.build
			@rent_houses = current_user.rent_houses.paginate(page: params[:page])
		else
      		render 'rent'
		end
	end

	def create
    	@rent_house = current_user.rent_houses.build(rentHouses_params)
      	@rent_house.img = params[:img].join(',')
    	if @rent_house.save
     	 	flash[:success] = "RentHouse created!"
      		redirect_to renthouse_path
    	else
      		redirect_to '/renthouse'
    	end
 	 end

  	def destroy
 		@rent_house.destroy
  		redirect_to renthouse_path
  	end


  private


    def rentHouses_params
      params.require(:rent_house).permit(:use, :address, :price, :size, :owner,
      									 :structure, :year, :floor, :breif, :note, :tel, :name, :email, :district, :around_list, :img)
    
    end
	
	def correct_user
      @rent_house = current_user.rent_houses.find_by(id: params[:id])
      redirect_to root_url if @rent_house.nil?
    end
end
