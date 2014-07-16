class EventsController < ApplicationController

	# event that handle ajax get or post

	# event for search houses in database
	def show
		#check user is in which page
		if params[:data] == 'sale_houses'
    		@data = [ SaleHouse.find(params[:real_price_id]) ]
		elsif params[:data] == 'rent_houses'
    		@data = [ RentHouse.find(params[:real_price_id]) ]
		elsif params[:data] == 'real_price_deals'
    		@data = [ RealPriceDeal.find(params[:real_price_id]) ]
		else
    		@data = [ RentHouse.find(params[:real_price_id]) ]
			# error
		end

		#@data[0].increase_browse_rates

		# find building around this house by lat, lng (around 1km)
		@lat_upper = Float(params[:lat]) + 0.005
		@lat_lower = Float(params[:lat]) - 0.005
		@lng_upper = Float(params[:lng]) + 0.005
		@lng_lower = Float(params[:lng]) - 0.005

		#database select
		@data += Stores.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
		@data += Hospitals.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
		@data += Station.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
		@data += Childcareroster.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
		@data += PoliceStation.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
		@data += TainanMarket.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
		@data += TainanSchool.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
		@data += Dining.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)

		#return house information to user
		respond_to do |format|
			format.json { render :json => @data }
		end
	end

	def search
		@keyword = params[:district]
    	@data = RentHouse.where("address like ?", "%#{@keyword}%")
		@data = [ @data, " "]
		respond_to do |format|
			format.json { render :json => @data }
		end
	end


	def advancedSearch
		@district = params[:district]
		if !params[:price] && !params[:district]
    		@data = RentHouse.where("address like ?", "%#{@district}%").where(:price => params[:price].split(" ")[0]...params[:price].split(" ")[1]).where(:people => params[:people])
		elsif params[:price]
    		@data = RentHouse.where(:price => params[:price].split(" ")[0]...params[:price].split(" ")[1]).where(:people => params[:people] )
		else
    		@data = RentHouse.where("address like ?", "%#{@district}%").where(:people => params[:people])
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

end
