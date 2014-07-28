# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: rent_houses
#
#  id       :integer          not null, primary key
#  string   "owner"
#  string   "address"
#  string   "structure"
#  string   "size"
#  string   "year"
#  string   "floor"
#  string   "email"
#  string   "tel"
#  text     "information"
#  string   "note"
#  datetime "created_at"
#  datetime "updated_at"
#  integer  "user_id"
#  string   "type"
#  float    "lat"
#  float    "lng"
#  string   "data",        default: "rent_houses"
#  string   "use"
#  string   "district"
#  string   "around_list"
#  string   "img"
#  integer  "price"
#  integer  "people"
#  integer  "browse_rate", default: 0

class RentHouse < ActiveRecord::Base
  belongs_to :user, :counter_cache => true
  validates :user_id, presence: true
  validates_presence_of :use, :structure, :address, :price, :owner, :tel, :information, :people
  validates_length_of :information, :minimum => 1, :maximum => 200
  validates_numericality_of :price, :people

  geocoded_by :address,
    :latitude => :lat, :longitude => :lng
  after_validation :geocode
  before_create :set_around_list

  scope :initial, -> { select("id, lat, lng, address, data") }


  def set_img(img)
    self.img = img.join(',')
  end 

  def set_around_list

    @lat_upper = self.lat + 0.005
    @lat_lower = self.lat - 0.005
    @lng_upper = self.lng + 0.005
    @lng_lower = self.lng - 0.005
    @number_list =  ""
    @number_list += Stores.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper).count.to_s + " "
    @number_list += Market.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper).count.to_s + " "
    @number_list += Dining.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper).count.to_s + " "
    @number_list += Station.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper).count.to_s 
    #@number_list += Hospitals.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper).length.to_s + " "
    #@number_list += Childcareroster.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper).length.to_s + " "
    #@number_list += PoliceStation.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper).length.to_s + " "
    #@number_list += TainanSchool.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper).length.to_s + " "
    self.around_list = @number_list
  end

  def increase_browse_rates
    update_attributes(:browse_rate => browse_rate +  1)
  end

  def get_around_data
    # find building around this house by lat, lng (around 1km)
    @lat_upper = Float(self.lat) + 0.005
    @lat_lower = Float(self.lat) - 0.005
    @lng_upper = Float(self.lng) + 0.005
    @lng_lower = Float(self.lng) - 0.005

    #database select
    @data = []
    @data += Stores.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
    @data += Hospitals.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
    @data += Station.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
    @data += Market.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
    @data += Dining.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
    @data += PostOffice.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
    @data += GasStation.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
    @data += Subway.where(:lat => @lat_lower...@lat_upper, :lng => @lng_lower...@lng_upper)
  end

  def self.get_ranking(price, district, people, rating)

    if price.present? && district.present?
      @data = RentHouse.where("address like ?", "%#{@district}%").where(:price => 
                                                                        price.split(" ")[0]...price.split(" ")[1]).where(:people => people)
    elsif price.present?
      @data = RentHouse.where(:price => price.split(" ")[0]...price.split(" ")[1]).where(:people => people )
    else
      @data = RentHouse.where("address like ?", "%#{@district}%").where(:people => people)
    end

    if rating.present?
      @score_list = []
      for house in @data
        @score = 0
        for i in 0...rating.length
          @score = @score + house['around_list'][i].to_i * rating[i].to_i
        end
        @score_list << @score
      end
      @rank = @score_list.map.with_index.sort_by(&:first).map(&:last) 
      
      @data = [@data, @rank]
    else
      @data = [@data, " "]
    end
  end
end
