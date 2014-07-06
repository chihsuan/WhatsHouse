class RentHouse < ActiveRecord::Base
	belongs_to :user
	validates :user_id, presence: true
	validates_presence_of :use, :structure, :address, :price, :owner, :tel, :breif, :img
	#validates_numericality_of :price, :only_integer => true 
	validates :breif, :length => { :minimum => 1, :maximum => 120 }
	default_scope -> { order('created_at DESC') }

	geocoded_by :address,
		 :latitude => :lat, :longitude => :lng
	after_validation :geocode
	before_create :set_around_list

	def set_around_list

		@lat_upper = self.lat + 0.005
		@lat_lower = self.lat - 0.005
		@lng_upper = self.lng + 0.005
		@lng_lower = self.lng - 0.005
		@number_list =  ""
		@number_list += Stores.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper).length.to_s + " "
		@number_list += TainanMarket.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper).length.to_s + " "
		@number_list += Dining.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper).length.to_s 
		@number_list += Station.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper).length.to_s + " "
		#@number_list += Hospitals.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper).length.to_s + " "
		#@number_list += Childcareroster.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper).length.to_s + " "
		#@number_list += PoliceStation.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper).length.to_s + " "
		#@number_list += TainanSchool.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper).length.to_s + " "
		self.around_list = @number_list
	end
end
