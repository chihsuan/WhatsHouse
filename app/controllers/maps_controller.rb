class MapsController < ApplicationController
	
	#show house data in map
	def show
		gon.real_price_list = RentHouse.initial.as_json()
	end
end
