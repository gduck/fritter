class CategoriesController < ApplicationController
  def index
    if params[:keyword]
      @categories = Category.where(simplified_name: params[:keyword]) 
    else
      @categories = Category.all
    end
  end

  def show
    puts ">>>>>>>>>>>>>>>>>>>>>> in show"
    puts params
    @category = Category.find_by(:simplified_name => params[:simplified_name])
    # puts @category
    # puts @category.name
    # puts @category.simplified_name
    # puts @category.id
  end

end
