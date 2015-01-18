namespace :scrape do 
  desc "Scraping Pinterest"
  task :get_posts => :environment do

    require 'open-uri'
    require 'nokogiri'
    # require 'date'



    # url = "http://pinterest.com/search/pins/?q=#{params[:q]}"
    url = "https://www.pinterest.com/categories/popular/"
    scrape_site(url)
    # scrape_images(url)
  end

  def scrape_site(url)

    document = open(url).read
    html_doc = Nokogiri::HTML(document)
    #puts html_doc

    data_pin_link = "a.pinImageWrapper"
    pin_links = html_doc.css(data_pin_link)
    puts "number of pin links " + pin_links.count.to_s
    puts pin_links

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
      
      puts "IN PAGE " + url

      data_orig_link = "a.paddedPinLink"
      orig_link = html_doc.css(data_orig_link)
      # puts orig_link.inspect
      puts orig_link[0]['href']

      data_picture_url = "img.pinImg"
      picture_url = html_doc.css(data_picture_url)
      puts picture_url[0]['src']

      data_repin_count = "button.repinLikeNavigateButton.IncrementingNavigateButton > span.buttonText"
      repin_count = html_doc.css(data_repin_count)
      if !repin_count.any?
        puts "no repins yet"
      else 
        # puts repin_count
        puts "repins " + repin_count[0].inner_text.to_s   
      end

      data_like_count = "button.repinLikeNavigateButton.like > span"
      like_count = html_doc.css(data_like_count)
      if !like_count.any?
        puts "no likes yet"
      else 
        # puts like_count
        puts "likes " + like_count[0].inner_text.to_s
      end



    end
end


     # data_category_list = "div.ajax.Module.CategoriesMenu > div.categoriesWrapper > ul.column0 > li:nth-child(19) > a:nth-child(1).item"
    # category_list = html_doc.css(data_category_list)
    # puts category_list

    # data_post_img = "img.pinImg"
    # post_imgs = html_doc.css(data_post_img)
    # puts "IMG " + post_imgs.count.to_s
    # puts post_imgs
    # urls = post_imgs.map {|i| i.get_attribute('src')}
    # puts urls

    # data_post_title = "div.PinBase.ajax.Pin.Module.summary > div.pinWrapper > div.richPinMeta > a.richPinMetaLink > h3.richPinGridTitle"
    # post_title = html_doc.css(data_post_title)
    # puts "TITLE " + post_title.count.to_s

    # data_post_description = "div > div.PinBase.ajax.Pin.Module.summary > div.pinWrapper > div.pinMeta > p.pinDescription"
    # post_description = html_doc.css(data_post_description)
    # puts "DESC " + post_description.count.to_s

    # data_orig_url = "div.Pin > div.pinWrapper > div.pinImageActionButtonWrapper > a"
    # orig_url = html_doc.css(data_orig_url)
    # puts "ORIG_URL " + orig_url.count.to_s
    # puts orig_url

    # data_category = "div > div > div > a > div.creditTitle"
    # category = html_doc.css(data_category)
    # puts "CATEGORY " + category.count.to_s

    # data_number_of_pins = "div.PinBase.ajax.Pin.Module.summary > div.pinWrapper > div.pinMeta > div.pinSocialMeta > a.socialItem > em.socialMetaCount.repinCountSmall"
    # number_of_pins = html_doc.css(data_number_of_pins)
    # puts "#PINS " + number_of_pins.count.to_s

    # data_number_of_likes = "div.PinBase.ajax.Pin.Module.summary > div.pinWrapper > div.pinMeta > div.pinSocialMeta > a.socialItem.likes > em.socialMetaCount.likeCountSmall"
    # number_of_likes = html_doc.css(data_number_of_likes)
    # puts "#LIKES " +number_of_likes.count.to_s



