namespace :scrapefirst do 
  desc "Scrape Categories from Pinterest"

  task :get_categories => :environment do
    require 'open-uri'
    require 'nokogiri'

    url = "https://www.pinterest.com/categories/"
    get_categories(url)
  end

  def get_categories(url) 
    document = open(url).read
    html_doc = Nokogiri::HTML(document)
    
    puts "--------------------"
    puts "IN PAGE " + url

    data_category_list = "a.categoryLinkWrapper"
    category_list = html_doc.css(data_category_list)

    category_list.each do |item|
      category_name = item.css("div.name").inner_text
      category_link = item['href']
      puts category_link
      #puts category_name
      #new_category = Category.create(simplified_name: category_link, name: category_name)
      #puts new_category.name
      #puts new_category.link
    end
  end
end