class PinController < ApplicationController
  before_action :signed_in_user
  
  def new 
    @pin = Pin.new
  end
  
  def index
    @pins = Pin.all
    @hash = Gmaps4rails.build_markers(@pins) do |pin, marker|
      marker.lat pin.latitude
      marker.lng pin.longitude
    end
  end
  
    def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end
  
  
end
