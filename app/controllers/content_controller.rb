class ContentController < ApplicationController
	# main content controller

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

end
