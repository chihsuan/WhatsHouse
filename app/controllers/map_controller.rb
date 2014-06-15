# encoding: utf-8
class MapController < ApplicationController
	def index:
		@real_price_list = RealPriceDeal.all
		gon.real_price_list = @real_price_list.as_json()
	end
end
