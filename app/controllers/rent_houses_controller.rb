# -*- encoding : utf-8 -*-

class RentHousesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :click_marker, :search, :advanced_search]
  before_action :find_user, except: [:index, :click_marker, :search, :advanced_search]
  before_action :find_house, only: [:edit, :update, :destroy, :show]

  def index
    # Initial house data for js  
    gon.house_lisr = RentHouse.initial.as_json()
  end

  def show
  end

  def edit
  end

  def update
    if @rent_house.update_attributes(rentHouses_params)
      flash[:success] = "更新成功!"
      redirect_to rent_house_path(@rent_house)
    else
      render :edit
    end
  end

  def new
    @rent_house = @user.rent_houses.build
    #@rent_houses = @user.rent_houses.paginate(page: params[:page])
  end

  def create
    @rent_house = current_user.rent_houses.build(rentHouses_params)
    @rent_house.set_img(params[:img]) if params[:img].present?
    
    if @rent_house.save
      flash[:success] = "RentHouse created!"
      redirect_to @user
    else
      render :new
    end
  end

  def destroy
    @rent_house.destroy
    
    redirect_to users_path(@user)
  end

  # For ajax return house data
  def click_marker

    @rent_house =  RentHouse.find(params[:rent_house_id])
    @around_data = @rent_house.get_around_data

    #return house information to user
    respond_to do |format|
      format.json { render :json => [@rent_house, @around_data] }
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

    @data = RentHouse.get_ranking_data(params[:district], params[:price], params[:people])
    @district = params[:district]

    if params[:price].present? && params[:district].present?
      @data = RentHouse.where("address like ?", "%#{@district}%").where(:price => params[:price].split(" ")[0]...params[:price].split(" ")[1]).where(:people => params[:people])
    elsif params[:price].present?
      @data = RentHouse.where(:price => params[:price].split(" ")[0]...params[:price].split(" ")[1]).where(:people => params[:people] )
    else
      @data = RentHouse.where("address like ?", "%#{@district}%").where(:people => params[:people])
    end

    if params[:rating].present?
      @data = [@data] + [" "]
    end
    
    respond_to do |format|
      format.json { render :json => @data }
    end
  end

  private

  def rentHouses_params
    params.require(:rent_house).permit(:use, :address, :price, :owner, :structure, 
                                       :information, :tel, :name, :around_list, :img, :people)
  end

  def find_user
    @user = current_user
  end

  def find_house
    @rent_house = current_user.rent_houses.find(params[:id])
    redirect_to root_url if @rent_house.nil?
  end
end
