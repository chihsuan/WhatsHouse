# -*- encoding : utf-8 -*-
# This controller is for static pages such about_us, contact_us...

class PagesController < ApplicationController

  # home page
  def index
    if signed_in? 
      redirect_to rent_houses_path
    end
  end

  def about_us
  end

  def contact
  end

end
