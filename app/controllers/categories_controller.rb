class CategoriesController < ApplicationController
  def index
    if params[:keyword]
      @categories = Category.where(link: params[:keyword]) 
    else
      @categories = Category.all
    end
  end

  def show
    @category = Category.where(link: params[:keyword])
  end

end
