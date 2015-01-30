class PinsController < ApplicationController

  def index
    if params[:keyword]||params[:category_id] 
      puts "THIS SHOULD NOT HAPPEN WHEN I REFRESH!"
      permitted_params = params.permit(:category_id)

      @pins = Pin.includes(:category).where(permitted_params).where("title like '%#{params[:keyword]}%'").limit(50)

    else
      puts "THIS SHOULD HAPPEN WHEN I REFRESH! - YES"
      @pins = Pin.includes(:category).all
    end

  end

  def show
    @pin = Pin.find(params[:id])
  end
  
end
