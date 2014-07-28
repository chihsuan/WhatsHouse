# -*- encoding : utf-8 -*-

class RentHousesController < ApplicationController
  before_action :authenticate_user!, only:  [:show, :edit, :update, :destroy, :new, :create]
  before_action :find_house, only: [:show, :edit, :update, :destroy]

  def index
    gon.house_list = RentHouse.initial.as_json()
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
    @rent_house = current_user.rent_houses.build
  end

  def create
    @rent_house = current_user.rent_houses.build(rentHouses_params)
    @rent_house.set_img(params[:img]) if params[:img].present?

    if @rent_house.save
      flash[:success] = "RentHouse created!"
      redirect_to users_path(@user)
    else
      render :new
    end
  end

  def destroy
    @rent_house.destroy

    redirect_to user_path(@user)
  end

  def get_data

    @rent_house =  RentHouse.find(params[:id]) 
    @data = [@rent_house] + @rent_house.get_around_data

    respond_to do |format|
      format.json { render :json => @data }
    end
  end

  def search
    @data = RentHouse.where("address like ?", "%#{params[:district]}%")

    respond_to do |format|
      format.json { render :json => [@data, " "] }
    end
  end


  def advanced_search

    @data = RentHouse.get_ranking(params[:price], params[:district], params[:people], params[:rating])
    
    respond_to do |format|
      format.json { render :json => @data }
    end
  end

  private

  def rentHouses_params
    params.require(:rent_house).permit(:use, :address, :price, :owner, :structure, 
                                       :information, :tel, :name, :around_list, :img, :people)
  end

  def find_house
    @user = current_user
    @rent_house = @user.rent_houses.find(params[:id])
    redirect_to root_url if @rent_house.nil?
  end

end
