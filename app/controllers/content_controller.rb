class ContentController < ApplicationController
	# main content controller

	def analysis
		@real_price_list = RealPriceDeal.select("id, lat, lng, location, data")
		gon.real_price_list = @real_price_list.as_json()
	end

	# home page
	def content
		if signed_in? 
			redirect_to rent_path
		end
		@user = User.new
	end

	# rent page
	def rent
		@rent_houses = RentHouse.select("id, lat, lng, address, data")
		gon.real_price_list = @rent_houses.as_json()
	end
	
	def about
	end

	def contact
	end

=begin
	def buy
		@sale_houses = SaleHouse.select("id, lat, lng, address, data")
		gon.real_price_list = @sale_houses.as_json()
	end
=end
end
