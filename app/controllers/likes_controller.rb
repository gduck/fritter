class LikesController < ApplicationController

 def index
    if current_user
      @pins = current_user.pins.includes(:category).limit(params[:limit]).offset(params[:offset])
      # @likes = current_user.likes.includes(:pin).limit(params[:limit]).offset(params[:offset])
    else
      @pins = nil
    end
  end

end
