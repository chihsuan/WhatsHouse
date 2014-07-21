class RentHouse < ActiveRecord::Base
	belongs_to :user, :counter_cache => true
	validates :user_id, presence: true
	validates_presence_of :use, :structure, :address, :price, :owner, :tel, :information, :img
	validates :breif, :length => { :minimum => 1, :maximum => 120 }
	geocoded_by :address,
		:latitude => :lat, :longitude => :lng
	after_validation :geocode
	before_create :set_around_list
	
	scope :initial, -> { select("id, lat, lng, address, data") }

	def set_around_list

		@lat_upper = self.lat + 0.005
		@lat_lower = self.lat - 0.005
		@lng_upper = self.lng + 0.005
		@lng_lower = self.lng - 0.005
		@number_list =  ""
		@number_list += Stores.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper).length.to_s + " "
		@number_list += TainanMarket.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper).length.to_s + " "
		@number_list += Dining.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper).length.to_s + " "
		@number_list += Station.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper).length.to_s 
		#@number_list += Hospitals.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper).length.to_s + " "
		#@number_list += Childcareroster.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper).length.to_s + " "
		#@number_list += PoliceStation.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper).length.to_s + " "
		#@number_list += TainanSchool.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper).length.to_s + " "
		self.around_list = @number_list
	end

	def increase_browse_rates
		update_attributes(:browse_rate => browse_rate +  1)
	end
end
