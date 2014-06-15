class EventsController < ApplicationController

	def show
    	@data = RealPriceDeal.find(10)
		respond_to do |format|
			format.json { render :json => @data }
		end
	end
end
