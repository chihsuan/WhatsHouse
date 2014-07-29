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
  before_save :join_img

  scope :initial, -> { select("id, lat, lng, address, data") }
  scope :address_is, -> (district) { where("address like ?", "%#{district}%") }
  scope :price_is, -> (price) { where(:price => price.split(" ")[0]...price.split(" ")[1]) }
  scope :people_is, -> (people) { where(:people => people) }
  scope :area_select, -> (lat_lower, lat_upper, lng_lower, lng_upper) { where(:lat => lat_lower...lat_upper, :lng => lng_lower...lng_upper) }


  def set_around_list
    set_lat_lng
    self.around_list = []
    self.around_list = Stores.area_select(@lat_lower, @lat_upper, @lng_lower, @lng_upper).count
    self.around_list += Market.area_select(@lat_lower, @lat_upper, @lng_lower, @lng_upper).count
    self.around_list += Dining.area_select(@lat_lower, @lat_upper, @lng_lower, @lng_upper).count
    self.around_list += Station.area_select(@lat_lower, @lat_upper, @lng_lower, @lng_upper).count
  end

  def get_around_data
    set_lat_lng
    data = [Stores.area_select(@lat_lower, @lat_upper, @lng_lower, @lng_upper)]
    data += Hospitals.area_select(@lat_lower, @lat_upper, @lng_lower, @lng_upper)
    data += Station.area_select(@lat_lower, @lat_upper, @lng_lower, @lng_upper)
    data += Market.area_select(@lat_lower, @lat_upper, @lng_lower, @lng_upper)
    data += Dining.area_select(@lat_lower, @lat_upper, @lng_lower, @lng_upper)
    data += PostOffice.area_select(@lat_lower, @lat_upper, @lng_lower, @lng_upper)
    data += GasStation.area_select(@lat_lower, @lat_upper, @lng_lower, @lng_upper)
    data += Subway.area_select(@lat_lower, @lat_upper, @lng_lower, @lng_upper)
  end

  def self.get_ranking(price, district, people, rating)

    query_data = district.present? ? self.address_is(district) : address_is("")  
    query_data = query_data.merge(price_is(price)) if price.present?
    query_data = query_data.merge(people_is(people)) if people.present?

    ranking_list = [query_data, calculate_score(query_data, rating)] 
  end

  def self.calculate_score(data, rating)

    if rating.blank?
      return  " "
    end

    score_list = []
    for house in data
      score = 0
      for i in 0...rating.length
        score = score + house['around_list'][i].to_i * rating[i].to_i
      end
      score_list << score
    end
    score_list = score_list.map.with_index.sort_by(&:first).map(&:last) 
  end


  def set_lat_lng
    @lat_upper = self.lat + 0.005
    @lat_lower = self.lat - 0.005
    @lng_upper = self.lng + 0.005
    @lng_lower = self.lng - 0.005 
  end

  def join_img
    self.img = img.join(',') if self.img.present?
  end 

  def increase_browse_rates
    update_attributes(:browse_rate => browse_rate + 1)
  end

end
