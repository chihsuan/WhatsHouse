class RentHousesController < ApplicationController
	before_action :signed_in_user
	before_action :find_house, only: [:edit, :update, :destroy, :show]

	def show
	end

	def edit
	end

	def update
		if @rent_house.update_attributes(rentHouses_params)
			flash[:success] = "更新成功!"
			redirect_to @rent_house
		else
			render :edit
		end
	end

	def new
		@user = current_user
		@rent_house = current_user.rent_houses.build
		@rent_houses = current_user.rent_houses.paginate(page: params[:page])
	end

	def create
		begin
			@rent_house = current_user.rent_houses.build(rentHouses_params)
			@rent_house.img = params[:img].join(',')
			if @rent_house.save
				flash[:success] = "RentHouse created!"
				redirect_to rent_path
			else
				@user = current_user
				render :new
			end
		rescue Exception => ex
			flash[:error] = "#{ex}"
			render :new
		end
	end

	def destroy
		@rent_house.destroy
		@user = current_user
		redirect_to current_user
	end


	private

	def rentHouses_params
		params.require(:rent_house).permit(:use, :address, :price, :owner, :structure, 
																			 :information, :tel, :name, :email, :district, :around_list, :img, :people)
	end

	def find_house
		@rent_house = current_user.rent_houses.find_by(id: params[:id])
		redirect_to root_url if @rent_house.nil?
	end
end
