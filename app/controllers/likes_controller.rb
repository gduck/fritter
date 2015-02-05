class LikesController < ApplicationController

 def index
    # if current_user
    if params[:keyword]||params[:category_id] 
      permitted_params = params.permit(:category_id)
      @pins = current_user.pins.includes(:category).where(permitted_params).where("title LIKE '%#{params[:keyword]}%'").order('created_at DESC').limit(params[:limit]).offset(params[:offset])
      puts ">>>>>>>>>>>>>>>>>>>> @pins " + @pins.to_s
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
    puts ">>>>>>>>>>>>>>>>>>>>>>>> NEW LIKE" + @like.to_s
    if like.save
      redirect_to :back
    else
      puts "ERROR SAVING OUR LIKE "
    end
  end

  protected
  def permitted_params 
    params.require(:like).permit(:user_id, :pin_id)
  end

end
