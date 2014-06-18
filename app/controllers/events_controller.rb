class EventsController < ApplicationController

	def show
    	if params[:data] == 'sale_houses'
    		@data = SaleHouse.find(params[:real_price_id])
		elsif params[:data] == 'rent_houses'
    		@data = RentHouse.find(params[:real_price_id])
		elsif params[:data] == 'real_price_deals'
    		@data = RealPriceDeal.find(params[:real_price_id])
		else 
			# error
		end
	
		respond_to do |format|
			format.json { render :json => @data }
		end
	end

end

