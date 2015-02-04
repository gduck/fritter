class LikesController < ApplicationController

 def index
    if current_user
      # @pins = nil
      puts ">>>>>>>>>>>>>>>>>>>>>> before get LIKES "
      # @likes = Like.where(user_id: current_user.id).includes(:pin).limit(params[:limit]).offset(params[:offset])
      # Like.where(user_id: 45).includes(:pin).limit(20)
      @likes = current_user.likes.includes(:pin).limit(params[:limit]).offset(params[:offset])
      puts ">>>>>>>>>>>>>>>>>>>>>> LIKES " + @likes.count.to_s
    else
      @likes = nil
    end
  end

end
