# -*- encoding : utf-8 -*-
require 'spec_helper'
describe RentHousesController do

  before do
    @user = User.new
    @rent_house = RentHouse.new
    @rent_house.stub!(to_param: '1')
    @user.stub!(to_param: '1')
    controller.stub!(:authenticate_user!)
    controller.stub!(:current_user).and_return(@user)
  end

  let(:current_user) { @user }

  describe 'GET show' do
    it 'should render successful' do
      #RentHouse.should_receive(:find).with('1').and_return(@rent_house) 
      #get :show, user_id: 1, id: 1
    end
  end

  describe 'GET new' do
    it 'should render successful' do
      RentHouse.should_receive(:new).and_return(@rent_house)
      get :new, user_id: 1
      assigns[:rent_house].should eq @rent_house
      response.should be_success
    end
  end


  describe 'POST create' do
    it 'should save successful and redirect to rent_path' do
      current_user.rent_houses.should_receive(:build).with("use"=>"living", "address"=>"tainan, taiwan", "price"=> '1000', "owner"=>"chihsuan", "structure"=>"4 room", "information"=>"for rent", "tel"=>"02-229222", "img" => "123.jpg 111.jpg", "people" => "4").and_return(@rent_house)
      @rent_house.should_receive(:save).and_return(true)
      post :create, user_id: 1, id: 1, rent_house: { use: 'living', structure: '4 room', 
        address: 'tainan, taiwan', price: 1000, 
        owner:  'chihsuan', tel: '02-229222',
        information:  'for rent', people: 4, img: '123.jpg 111.jpg'}

      response.should be_redirect     
    end
  end

  describe 'GET edit' do
    it 'should render successful' do
      current_user.stub_chain(:rent_houses, :find).with('1').and_return(@rent_house)
      get :edit, user_id: 1, id: 1

      assigns[:rent_house].should eq @rent_house
      response.should be_success
    end
  end

  describe 'PUT update' do
    it 'should save successful and redirect to show' do
      current_user.stub_chain(:rent_houses, :find).with('1').and_return(@rent_house)
      @rent_house.should_receive(:update_attributes).with('price' => '1222', 'information' => 'air conditioner', 'img' => '11 11').and_return(true)
      put :update, user_id: 1, id: 1, rent_house: { price: '1222', information: 'air conditioner', img: '11 11'} 

      response.should be_redirect
    end
  end

  describe 'DELETE destroy' do
    it 'should delete successful' do
      current_user.stub_chain(:rent_houses, :find).with('1').and_return(@rent_house)
      @rent_house.should_receive(:destroy)
      delete :destroy, user_id: 1, id: 1
      response.should be_redirect
    end 
  end

end
