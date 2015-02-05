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
    if like.save
      render json: {success: true}
    else
      render json: {success: false}
    end
  end

  def destroy
    like = current_user.likes.find_by(search_params)
    like.destroy
    render json: {status: 200, params: params}
  end

  protected
  def permitted_params 
    params.permit(:pin_id)
  end

  def search_params 
    params.permit(:pin_id)
  end

end
