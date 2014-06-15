class ContentController < ApplicationController
	def content
		@real_price_list = RealPriceDeal.all
		gon.real_price_list = @real_price_list.as_json()
	end
end
