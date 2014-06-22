class ContentController < ApplicationController
	
	def analysis
		@real_price_list = RealPriceDeal.select("id, lat, lng, location, data")
		gon.real_price_list = @real_price_list.as_json()
	end

	def content
		@user = User.new
		@sale_houses = SaleHouse.select("id, lat, lng, address, data")
		gon.real_price_list = @sale_houses.as_json()
	end

	def rent
		@rent_houses = RentHouse.select("id, lat, lng, address, data")
		gon.real_price_list = @rent_houses.as_json()
	end

	def buy
		@sale_houses = SaleHouse.select("id, lat, lng, address, data")
		gon.real_price_list = @sale_houses.as_json()
	end

end
