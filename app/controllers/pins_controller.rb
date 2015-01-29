class PinsController < ApplicationController

  def index
    @pins = Pin.search(params[:search]).limit(50)
  end

  def show
    @pin = Pin.find(params[:id])
  end
  
end
