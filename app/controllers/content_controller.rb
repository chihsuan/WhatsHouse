class ContentController < ApplicationController


	def content
		@real_price_list = RealPriceDeal.select("id, lat, lng, location")
		gon.real_price_list = @real_price_list.as_json()
	end

end
