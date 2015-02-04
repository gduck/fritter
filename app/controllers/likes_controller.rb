class LikesController < ApplicationController

 def index
    if current_user?
      @pins = current_user.likes.includes(:pin).includes(:category).limit(params[:limit]).offset(params[:offset])
    end
  end

end
