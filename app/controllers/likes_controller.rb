class LikesController < ApplicationController

 def index
    # if current_user
    if params[:keyword] || params[:category_id] 
      permitted_params = params.permit(:category_id)
      @pins = current_user.pins.includes(:category).where(permitted_params).where("title LIKE '%#{params[:keyword]}%'").order('created_at DESC').limit(params[:limit]).offset(params[:offset])
    else
      @pins = current_user.pins.includes(:category).order('created_at DESC').limit(params[:limit]).offset(params[:offset])
    end
  end

  def create
    like = current_user.likes.new(permitted_params)
    if like.save
      render json: {success: true}
    else
      puts "ERROR SAVING OUR LIKE "
      render json: {success: false}
    end
  end

  protected
  def permitted_params 
    params.require(:like).permit(:pin_id)
  end

end
