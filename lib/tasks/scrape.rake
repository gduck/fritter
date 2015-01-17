namespace :scrape do 
  desc "Scraping Pinterest"
  task :get_posts => :environment do

    require 'open-uri'
    require 'nokogiri'
    # require 'date'

    url = "http://pinterest.com/search/pins/?q=#{params[:q]}"
    scrape_this_url(url)
  end

  def scrape_this_url(url)

    document = open(url).read
    html_doc = Nokogiri::HTML(document)

    data_post_img = "img.pinImg"
    post_img = html_doc.css(data_company)

    data_post_title = "div.PinBase.ajax.Pin.Module.summary > div.pinWrapper > div.richPinMeta > a.richPinMetaLink > h3.richPinGridTitle"
    post_title = html_doc.css(data_job_title)

    data_post_description = "div > div.PinBase.ajax.Pin.Module.summary > div.pinWrapper > div.pinMeta > p.pinDescription"
    post_description = html_doc.css(data_job_description)

    data_orig_url = "div.PinBase.ajax.Pin.Module.summary > div.pinWrapper > div.pinImageActionButtonWrapper > a:nth-child(3).NavigateButton.Button.pinNavLink.navLinkOverlay.hasText.Module.ajax.borderless > span:nth-child(2).buttonText"
    orig_url = html_doc.css(data_job_id)

    data_category = "div > div > div > a > div.creditTitle"
    category = html_doc.css(data_job_date)

    data_number_of_pins = "div.PinBase.ajax.Pin.Module.summary > div.pinWrapper > div.pinMeta > div.pinSocialMeta > a.socialItem > em.socialMetaCount.repinCountSmall"
    number_of_pins = html_doc.css(data_job_date)

    data_number_of_likes = "div.PinBase.ajax.Pin.Module.summary > div.pinWrapper > div.pinMeta > div.pinSocialMeta > a.socialItem.likes > em.socialMetaCount.likeCountSmall"
    number_of_likes = html_doc.css(data_job_date)

  end

end
