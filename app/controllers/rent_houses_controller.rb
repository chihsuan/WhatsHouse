# -*- encoding : utf-8 -*-

class RentHousesController < ApplicationController
  before_filter :authenticate_user!, except: [:click_marker, :search, :advanced_search]
  before_action :find_house, only: [:edit, :update, :destroy, :show]

  def index
    gon.real_price_list = RentHouse.initial.as_json()
  end

  def show
  end

  def edit
    @user = current_user
  end

  def update
    if @rent_house.update_attributes(rentHouses_params)
      flash[:success] = "更新成功!"
      redirect_to user_rent_house_path(current_user, @rent_house)
    else
      render :edit
    end
  end

  def new
    @user = current_user
    @rent_house = @user.rent_houses.build
    @rent_houses = @user.rent_houses.paginate(page: params[:page])
  end

  def create
    @user = current_user
    @rent_house = current_user.rent_houses.build(rentHouses_params)
    @rent_house.set_img(params[:img]) if params[:img].present?
    
    if @rent_house.save
      flash[:success] = "RentHouse created!"
      redirect_to @user
    else
      @user = current_user
      render :new
    end
  end

  def destroy
    @rent_house.destroy
    @user = current_user
    redirect_to @user
  end

  # For ajax return house data
  def click_marker

    @data = [ RentHouse.find(params[:real_price_id]) ]

    # find building around this house by lat, lng (around 1km)
    @lat_upper = Float(params[:lat]) + 0.005
    @lat_lower = Float(params[:lat]) - 0.005
    @lng_upper = Float(params[:lng]) + 0.005
    @lng_lower = Float(params[:lng]) - 0.005

    #database select
    @data += Stores.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
    @data += Hospitals.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
    @data += Station.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
    @data += Market.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
    @data += Dining.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
    @data += PostOffice.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
    @data += GasStation.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
    @data += Subway.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)

    #return house information to user
    respond_to do |format|
      format.json { render :json => @data }
    end
  end

  def search
    @keyword = params[:district]
    @data = RentHouse.where("address like ?", "%#{@keyword}%")
    @data = [ @data, " "]
    respond_to do |format|
      format.json { render :json => @data }
    end
  end


  def advanced_search
    @district = params[:district]
    if !params[:price] && !params[:district]
      @data = RentHouse.where("address like ?", "%#{@district}%").where(:price => params[:price].split(" ")[0]...params[:price].split(" ")[1]).where(:people => params[:people])
    elsif params[:price]
      @data = RentHouse.where(:price => params[:price].split(" ")[0]...params[:price].split(" ")[1]).where(:people => params[:people] )
    else
      @data = RentHouse.where("address like ?", "%#{@district}%").where(:people => params[:people])
    end

    if params[:rating].present?
      @score_list = []
      for house in @data
        @tmp = 0
        for i in 0...params[:rating].length
          @tmp = @tmp + house['around_list'][i].to_i * params[:rating][i].to_i
        end
        @score_list << @tmp
      end
      @data = [@data] + [ @score_list.map.with_index.sort_by(&:first).map(&:last) ]
    else
      @data = [@data] + [" "]
    end
    respond_to do |format|
      format.json { render :json => @data }
    end
  end

  private

  def rentHouses_params
    params.require(:rent_house).permit(:use, :address, :price, :owner, :structure, 
                                       :information, :tel, :name, :email, :district, :around_list, :img, :people)
  end

  def find_house
    @rent_house = current_user.rent_houses.find(params[:id])
    redirect_to root_url if @rent_house.nil?
  end
end
