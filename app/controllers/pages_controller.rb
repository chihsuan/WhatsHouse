# -*- encoding : utf-8 -*-

class PagesController < ApplicationController

  # home page
  def index
    if signed_in? 
      redirect_to rent_path
    end
  end

  def about_us
  end

  def contact
  end

end
