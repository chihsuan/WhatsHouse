class EventsController < ApplicationController
	def show
    	@data = RealPriceDeal.find(params[:real_price_id])
		respond_to do |format|
			format.json { render :json => @data }
		end
	end
end
