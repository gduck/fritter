class PinsController < ApplicationController

  def index
    @pins = Pin.all
  end

  def show
    @pin = Pin.find(params[:id])
  end

  def selectCategory
    @pins = Pin.where(category_id: params[:category_id]).limit(50)
  end
  
end
