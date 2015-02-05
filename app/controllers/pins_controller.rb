class PinsController < ApplicationController

  def index
    if params[:keyword] || params[:category_id] 
      permitted_params = params.permit(:category_id)
      @pins = Pin.includes(:category).where(permitted_params).where("title LIKE '%#{params[:keyword]}%'").order('created_at DESC').limit(params[:limit]).offset(params[:offset])
    else
      # lets get an interesting selection for our front page
      grabSomePins = Pin.includes(:category).all.order('RANDOM()').limit(50)
      @pins = grabSomePins.order('created_at DESC').limit(params[:limit]).offset(params[:offset])
    end
  end

  def show
    @pin = Pin.find(params[:id])
  end

  def unlike
    pin = Pin.find(params[:pin_id])
    pin.like_count = pin.like_count - 1
    if pin.save
      render json: {success: true}
    else
      render json: {success: false}
    end
  end

  def like
    pin = Pin.find(params[:pin_id])
    pin.like_count = pin.like_count + 1
    if pin.save
      render json: {success: true}
    else
      render json: {success: false}
    end
  end


  protected
  def permitted_params 
    params.require(:pin).permit(:keyword, :category_id, :limit, :offset)
  end
  
end
