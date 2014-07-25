# -*- encoding : utf-8 -*-
require 'spec_helper'
describe RentHousesController do

  before do
    @user = User.new
    @rent_house = RentHouse.new
    @rent_house.stub!(to_params: '1')
    controller.stub!(:authenticate_user!)
    controller.stub!(:current_user).and_return(@user)
  end

  let(:current_user) { @user }

  describe 'GET show' do

  end

  describe 'GET edit' do

  end

  describe 'PUT update' do

  end

  describe 'POST create' do

  end

  describe 'GET new' do

  end

  describe 'DELETE destroy' do

  end


end
