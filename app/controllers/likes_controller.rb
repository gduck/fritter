class LikesController < ApplicationController

 def index
    if params[:keyword] || params[:category_id] 
      permitted_params = params.permit(:category_id)
      @pins = current_user.pins.includes(:category).where(permitted_params).where("title LIKE '%#{params[:keyword]}%'").order('likes.id DESC').limit(params[:limit]).offset(params[:offset])
    else
      @pins = current_user.pins.includes(:category).order('likes.id DESC').limit(params[:limit]).offset(params[:offset])
    end
  end

  def create
    like = current_user.likes.new
    like.pin_id = params[:pin_id]

    pin = Pin.find(params[:pin_id])
    pin.like_count = pin.like_count + 1

    Like.transaction do
      begin
        pin.save
        like.save
        render json: {success: true}
      rescue 
        render json: {success: false}
      end
    end
  end

  def destroy
    like = current_user.likes.find_by(permitted_params)

    pin = Pin.find(params[:pin_id])
    pin.like_count = pin.like_count - 1

    Like.transaction do
      begin
        pin.save
        like.destroy
        render json: {success: true}
      rescue 
        render json: {success: false}
      end
    end
  end

  protected
  def permitted_params 
    params.permit(:pin_id)
  end

end
