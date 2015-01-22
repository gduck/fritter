namespace :scrape do 
  desc "Scraping Pinterest"
  task :get_posts => :environment do

    require 'open-uri'
    require 'nokogiri'
    # require 'date'

    # url = "http://pinterest.com/search/pins/?q=#{params[:q]}"
    Category.all.each do |category|
      url = "https://www.pinterest.com/categories/" + category.name + "/"
      scrape_site(url)
    end
  end

  def scrape_site(url)
    document = open(url).read
    html_doc = Nokogiri::HTML(document)

    data_pin_link = "a.pinImageWrapper"
    pin_links = html_doc.css(data_pin_link)
    puts "number of pin links " + pin_links.count.to_s

    pin_link_array = []

    pin_links.each_with_index do |link, index|
      pin_link_array.push(link['href'])
    end

    puts "array coming"
    puts pin_link_array

    domain_link = "https://www.pinterest.com"
    scrape_one_page(domain_link + pin_link_array[0])
  end


  # url will be of format 'https://www.pinterest.com/pin/556264991450154362/'
  def scrape_one_page(url)

    document = open(url).read
    html_doc = Nokogiri::HTML(document)
    
    puts "--------------------"
    puts "IN PAGE " + url

    puts "PAGE TITLE "+ html_doc.css('title').to_s

    data_orig_link = "a.paddedPinLink"
    orig_link = html_doc.css(data_orig_link)
    # puts orig_link.inspect
    puts "SOURCE URL "+ orig_link[0]['href']

    data_picture_url = "img.pinImg"
    picture_url = html_doc.css(data_picture_url)
    puts "PINTEREST URL " +picture_url[0]['src']

    data_repin_count = "meta[name=\"pinterestapp:repins\"]"
    repin_count = html_doc.css(data_repin_count)
    #puts repin_count
    if not repin_count.any?
      puts "no repins yet"
    else 
      # puts repin_count
      puts "REPINS " + repin_count[0]['content'] 
    end

    # <meta name="pinterestapp:likes" content="875">
    data_like_count = "meta[name=\"pinterestapp:likes\"]"
    like_count = html_doc.css(data_like_count)
    #puts like_count
    if not like_count.any?
      puts "no likes yet"
    else 
      # puts like_count
      puts "LIKES " + like_count[0]['content']
    end

    # need to do title & description
    data_title = "h2.richPinName > a"
    title = html_doc.css(data_title)
    #puts title.to_s
    if not title.any?
      puts "no title for this one"
    else
      #puts title.inspect
      puts "TITLE " + title.inner_text.strip
    end

    data_description = "meta[name=\"description\"]"
    description = html_doc.css(data_description)
    #puts description
    puts "DESC " +description[0]['content']
    puts "--------------------"

  end

  task :get_categories => :environment do

    require 'open-uri'
    require 'nokogiri'

    # url = "http://pinterest.com/search/pins/?q=#{params[:q]}"
    url = "https://www.pinterest.com/categories/"
    get_cats(url)
  end

  def get_cats(url) 

    document = open(url).read
      # need to wait for repin data to load
      # sleep 2
      html_doc = Nokogiri::HTML(document)
      
      puts "--------------------"
      puts "IN PAGE " + url

      data_category_list = "div > div > div > a > div.name"
      category_list = html_doc.css(data_category_list)

      category_list.each do |item|
        new_cat = Category.create(name: item.text)
        puts new_cat
      end

  end
end

