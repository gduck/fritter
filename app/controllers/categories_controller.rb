class CategoriesController < ApplicationController
  def index
    if params[:keyword]
      @categories = Category.where(simplified_name: params[:keyword]) 
    else
      @categories = Category.all
    end
  end

  def show
    @category = Category.where(simplified_name: params[:keyword])
  end

end
