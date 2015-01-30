class PinsController < ApplicationController

  def index
    permitted_params = params.permit(:category_id)

    @pins = Pin.where("title like '%#{params[:keyword]}%'").where(permitted_params).limit(50)
  end

  def show
    @pin = Pin.find(params[:id])
  end
  
end
