namespace :scrape do 
  desc "Scraping Pinterest"

  # must fill category table before doing this
  task :get_posts => :environment do
    require 'open-uri'
    require 'nokogiri'
    # require 'date'

    if (Category.all.count == 0) then
      puts "please run rake scrape:get_categories first"
      return
    end

    Category.all.each do |category|
      url = "https://www.pinterest.com" + category.link
      puts url
      # this is to pick up scraping 
      # half way through in case of (404) error
      # if (category.id > 20) then
      scrape_site(url, category.id)
      # end
    end
  end

  def scrape_site(url, categoryID)
    document = open(url).read
    html_doc = Nokogiri::HTML(document)

    data_pin_link = "a.pinImageWrapper"
    pin_links = html_doc.css(data_pin_link)
    number_pins = pin_links.count
    puts "number of pin links " + number_pins.to_s
    # if number_pins == 0 then
    #   return
    # else
    #   puts pin_links
    # end 

    pin_link_array = []
    domain_link = "https://www.pinterest.com"

    pin_links.each_with_index do |link, index|
      pin_link = link['href']
      puts pin_link
      pin_link_array.push(pin_link)
      puts domain_link + pin_link
      scrape_one_page(domain_link + pin_link, categoryID)
    end
  end


  # url will be of format 'https://www.pinterest.com/pin/556264991450154362/'
  def scrape_one_page(url, categoryID)
    puts "about to scrape :" + url
    document = open(url).read
    html_doc = Nokogiri::HTML(document)
    newPin = Pin.new(category_id: categoryID)
    
    puts "--------------------"
    puts "IN PAGE " + url

    newPin.pinterest_id = url.split('/').fifth
    puts "PINTERST ID: " + newPin.pinterest_id

    # sometimes there is not title. If that's the case
    # I want to use the page title instead
    data_title = "h2.richPinName > a"
    title = html_doc.css(data_title)
    #puts title.to_s
    if not title.any?
      puts "* no title for this one, using page title instead"
      newPin.title = html_doc.css('title').text.to_s.gsub(/\| Pinterest/, "")
      puts "PAGE TITLE "+ newPin.title
    else
      #puts title.inspect
      newPin.title = title.inner_text.strip
      puts "TITLE " + newPin.title
    end

    data_orig_link = "a.paddedPinLink"
    orig_link = html_doc.css(data_orig_link)
    link = orig_link[0]['href']
    puts "the original link" + link
    newPin.source_url = orig_link[0]['href']
    puts "SOURCE URL "+ newPin.source_url

    # occasional pictures have a div with class pinImg some have pinImage. weird
    data_picture_url = ["img.pinImg", "img.pinImage"]
    picture_url = html_doc.css(data_picture_url[0])
    if not picture_url.any?
      picture_url = html_doc.css(data_picture_url[1])
      puts "had to check other class for pinImage"
      if not picture_url.any?
        puts "looks like nothing here, returning"
        return
      end
    end
    newPin.img_url = picture_url[0]['src']
    puts "IMG URL " + newPin.img_url

    # not using repins in fritter at the moment
    # data_repin_count = "meta[name=\"pinterestapp:repins\"]"
    # repin_count = html_doc.css(data_repin_count)
    # if not repin_count.any?
    #   puts "no repins yet"
    # else 
    #   puts "REPINS " + repin_count[0]['content'] 
    # end

    data_like_count = "meta[name=\"pinterestapp:likes\"]"
    like_count = html_doc.css(data_like_count)
    #puts like_count
    if not like_count.any?
      newPin.like_count = 0
      puts "no likes yet"
    else 
      newPin.like_count = like_count[0]['content']
      puts "LIKES " + newPin.like_count.to_s
    end

    # some descriptions mention Pinterest quite a lot
    # I wonder if it's ok to replace that with 'fritter'..?
    data_description = "meta[name=\"description\"]"
    description = html_doc.css(data_description)
    #puts description
    newPin.optional_info = description[0]['content'].gsub(/Pinterest/, "fritter")
    puts "DESC " + newPin.optional_info
    puts "--------------------"
    puts newPin.inspect
    puts "--------------------"
    newPin.save
    puts "PIN SAVED"
    puts "--------------------"
  end

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
      new_category = Category.create(link: category_link, name: category_name)
      puts new_category.name
      puts new_category.link
    end
  end
end

