# -*- encoding : utf-8 -*-
require 'spec_helper'
describe RentHousesController, :type => :controller do

  before do
    @user = FactoryGirl.create(:user)
    @rent_house = FactoryGirl.create(:rent_house)
    @rent_house.stub(to_param: '1')
    controller.stub(:authenticate_user!)
    controller.stub(:current_user).and_return(@user)
  end

  let(:current_user) { @user }

  describe 'GET index' do
    it 'should render successful' do
      expect(RentHouse.initial.as_json()).to eq([])
      get :index, user_id: 1, id: 1
      expect(response).to be_success
    end
  end

  describe 'GET show' do
    it 'should render successful' do
      expect(current_user.rent_houses.find(1)).to eq(@rent_houses)
      get :show, user_id: 1, id: 1
      expect(assigns[:rent_house]).to eq @rent_house
      expect(response).to be_success
    end
  end

  describe 'GET new' do
    it 'should render successful' do
      RentHouse.should_receive(:new).and_return(@rent_house)
      get :new, user_id: 1
      expect(assigns[:rent_house]).to eq @rent_house
      expect(response).to be_success
    end
  end

  describe 'POST create' do
    it 'should save successful and redirect to rent_path' do
      current_user.rent_houses.should_receive(:build).with("use"=>"living", "address"=>"tainan, taiwan", 
                                                           "price"=> '1000', "owner"=>"chihsuan", "structure"=>"4 room", 
                                                           "information"=>"for rent", "tel"=>"02-229222", 
                                                           "img" => "123.jpg 111.jpg", "people" => "4").and_return(@rent_house)
      @rent_house.should_receive(:save).and_return(true)
      post :create, user_id: 1, id: 1, rent_house: { use: 'living', structure: '4 room', 
        address: 'tainan, taiwan', price: 1000, 
        owner:  'chihsuan', tel: '02-229222',
        information:  'for rent', people: 4, img: '123.jpg 111.jpg'}

      expect(response).to be_redirect
    end
  end

  describe 'GET edit' do
    it 'should render successful' do
      current_user.stub_chain(:rent_houses, :find).with('1').and_return(@rent_house)
      get :edit, user_id: 1, id: 1

      expect(assigns[:rent_house]).to eq @rent_house
      expect(response).to be_success
    end
  end

  describe 'PUT update' do
    it 'should save successful and redirect to show' do
      current_user.stub_chain(:rent_houses, :find).with('1').and_return(@rent_house)
      @rent_house.should_receive(:update_attributes).with('price' => '1222', 
                                                          'information' => 'air conditioner', 'img' => '11 11').and_return(true)
      put :update, user_id: 1, id: 1, rent_house: { price: '1222', information: 'air conditioner', img: '11 11'} 

      expect(response).to be_redirect
    end

    it 'should save failed and render to edit' do
      current_user.stub_chain(:rent_houses, :find).with('1').and_return(@rent_house)
      put :update, user_id: 1, id: 1, rent_house: { price: '1222', information: '', img: '11 11'} 
      
      expect(response).to render_template(:edit)
      expect(response).to be_success
    end
  end

  describe 'DELETE destroy' do
    it 'should delete successful' do
      current_user.stub_chain(:rent_houses, :find).with('1').and_return(@rent_house)
      @rent_house.should_receive(:destroy)
      delete :destroy, user_id: 1, id: 1
      expect(response).to be_redirect
    end 
  end

end
