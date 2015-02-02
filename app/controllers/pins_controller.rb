class PinsController < ApplicationController

  def index
    # only category
    if params[:keyword].blank? && !params[:category_id].blank?
      permitted_params = params.permit(:category_id)
      @pins = Pin.includes(:category)
                 .where(permitted_params)
                 .limit(params[:limit]).offset(params[:offset])

    # only keyword
    elsif params[:category_id].blank? && !params[:keyword].blank?
      @pins = Pin.includes(:category)
                 .where("title like '%#{params[:keyword]}%'")
                 .limit(params[:limit]).offset(params[:offset])
    
    # both category and keyword
    elsif !params[:keyword].blank? && !params[:category_id].blank?
      permitted_params = params.permit(:category_id)
      @pins = Pin.includes(:category)
                 .where(permitted_params)
                 .where("title like '%#{params[:keyword]}%'")
                 .limit(params[:limit]).offset(params[:offset])

    # No category and no keyword
    else
      @pins = Pin.includes(:category)
                 .all
                 .limit(params[:limit]).offset(params[:offset])
    end

  end

  def show
    @pin = Pin.find(params[:id])
  end
  
end
