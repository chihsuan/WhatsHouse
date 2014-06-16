class StaticPagesController < ApplicationController

	def index
		if signed_in?
			@rent_house = current_user.rent_houses.build
		end
	end

	def help
	end

end
