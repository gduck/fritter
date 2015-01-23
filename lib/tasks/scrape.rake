namespace :scrape do 
  desc "Scraping Pinterest"
  task :get_posts => :environment do

    require 'open-uri'
    require 'nokogiri'
    # require 'date'

    # url = "http://pinterest.com/search/pins/?q=#{params[:q]}"
    Category.all.each do |category|
      url = "https://www.pinterest.com" + category.link
      puts url
      scrape_site(url, category.id)
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
    # first scrape one page per category list
    scrape_one_page(domain_link + pin_link_array[0], categoryID)
  end


  # url will be of format 'https://www.pinterest.com/pin/556264991450154362/'

  def scrape_one_page(url, categoryID)
    document = open(url).read
    html_doc = Nokogiri::HTML(document)

    newPin = Pin.new(category_id: categoryID)
    
    puts "--------------------"
    puts "IN PAGE " + url

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

    newPin.pin_url = orig_link[0]['href']
    puts "SOURCE URL "+ newPin.pin_url

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

    # not using repins in fritter
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

      data_category_list = "a.categoryLinkWrapper"
      category_list = html_doc.css(data_category_list)

      category_list.each do |item|
        #puts item['href']
        #puts item
        cat_name = item.css("div.name").inner_text
        #puts cat_name
        new_cat = Category.create(link: item['href'], name: cat_name)
        puts new_cat.name
        puts new_cat.link
      end

  end
      puts "PAGE TITLE "+ html_doc.css('title').to_s

      data_orig_link = "a.paddedPinLink"
      orig_link = html_doc.css(data_orig_link)
      # puts orig_link.inspect
      puts "SOURCE URL "+ orig_link[0]['href']

      data_picture_url = "img.pinImg"
      picture_url = html_doc.css(data_picture_url)
      puts "PINTEREST URL " +picture_url[0]['src']

      # <meta name="pinterestapp:repins" content="3776">
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
      # <meta name="description" content="&quot;One small crack does not mean that you are broken, it means that you we're put to the test and you didn't fall apart.&quot;">
      puts "--------------------"

    end
end

