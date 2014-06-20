class EventsController < ApplicationController

	def show
    	if params[:data] == 'sale_houses'
    		@data = [ SaleHouse.find(params[:real_price_id]) ]
		elsif params[:data] == 'rent_houses'
    		@data = [ RentHouse.find(params[:real_price_id]) ]
		elsif params[:data] == 'real_price_deals'
    		@data = [ RealPriceDeal.find(params[:real_price_id]) ]
		else 
			# error
		end
		@lat_upper = Float(params[:lat]) + 0.005
		@lat_lower = Float(params[:lat]) - 0.005
		@lng_upper = Float(params[:lng]) + 0.005
		@lng_lower = Float(params[:lng]) - 0.005

		@data += Stores.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
		@data += Hospitals.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
		@data += Station.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
		@data += Childcareroster.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
		@data += PoliceStation.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
		@data += TainanMarket.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
		@data += TainanSchool.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
		@data += Dining.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
		
		respond_to do |format|
			format.json { render :json => @data }
		end
	end

end

