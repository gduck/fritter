class LikesController < ApplicationController

 def index
    # if current_user
    if params[:keyword] || params[:category_id] 
      permitted_params = params.permit(:category_id)
      @pins = current_user.pins.includes(:category).where(permitted_params).where("title LIKE '%#{params[:keyword]}%'").order('created_at DESC').limit(params[:limit]).offset(params[:offset])
    else
      @pins = current_user.pins.includes(:category).order('created_at DESC').limit(params[:limit]).offset(params[:offset])
    end
      # @likes = current_user.likes.includes(:pin).limit(params[:limit]).offset(params[:offset])
    # else
      # @pins = nil
    # end
  end

  def create
    like = Like.new(permitted_params)
    if like.save
      redirect_to :back
    else
      puts "ERROR SAVING OUR LIKE "
    end
  end

  def destroy
    puts "PARAMS"
    puts params
    puts "SEARCH PARAMS"
    puts search_params
    # puts "PERMITTED PARAMS"
    # puts permitted_params
    alike = Like.find(user_id: params[:likes[:user_id]], pin_id: params[:likes[:pin_id]])
    puts "FINDING LIKE"
    puts alike
    # puts ">>>>>>>>>>>>>>>  FIND LIKE "+alike.to_s

    render json: {status: 200, params: params}
  end

  protected
  def permitted_params 
    params.require(:likes).permit(:user_id, :pin_id)
  end

  def search_params 
    params.permit(:user_id, :pin_id)
  end

end
