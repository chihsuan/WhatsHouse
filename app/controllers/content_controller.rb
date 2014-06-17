class ContentController < ApplicationController
	
	def analysis
		@real_price_list = RealPriceDeal.select("id, lat, lng, location")
		gon.real_price_list = @real_price_list.as_json()
	end

	def content
		@real_price_list = RealPriceDeal.select("id, lat, lng, location")
		gon.real_price_list = @real_price_list.as_json()
	end

end
