class Pin < ActiveRecord::Base
  validates :pininterest_id, uniqueness: true
  validates :pin_url,  presence: true #this is the original src url
  validates :like_count, numericality: true
  validates :category_id, presence: true
end
