class LikesController < ApplicationController

 def index
    if current_user
      @likes = current_user.likes.includes(:pin).limit(params[:limit]).offset(params[:offset])
    else
      @likes = nil
    end
  end

end
