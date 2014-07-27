# -*- encoding : utf-8 -*-
# This controller is for static pages such about_us, contact_us...

class PagesController < ApplicationController

  def index
    if signed_in? 
      gon.house_list = RentHouse.initial.as_json()
      render template:  'rent_houses/index.html.erb'
    end
  end

  def about_us
  end

  def contact
  end

end
