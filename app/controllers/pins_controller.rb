class PinsController < ApplicationController

  def index
    if params[:keyword]||params[:category_id] 
      permitted_params = params.permit(:category_id)
      @pins = Pin.includes(:category).where(permitted_params).where("title LIKE '%#{params[:keyword]}%'").order('created_at DESC').limit(params[:limit]).offset(params[:offset])
    else
      @pins = Pin.includes(:category).all.order('created_at DESC').limit(params[:limit]).offset(params[:offset])
    end
  end

  def show
    @pin = Pin.find(params[:id])
  end

  protected
  def permitted_params 
    params.require(:pin).permit(:keyword, :category_id, :limit, :offset)
  end
  
end
