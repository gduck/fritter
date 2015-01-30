class Pin < ActiveRecord::Base
  validates :pinterest_id, uniqueness: true
  validates :source_url,  presence: true #this is the original src url
  validates :like_count, numericality: true
  validates :category_id, presence: true

  belongs_to :category

  # def self.search(search)
  #   if search
  #     joins(:pins).where('(pins.title.downcase || pins.optional_info.downcase) LIKE ?', "%#{search}%").includes(:pins).limit(50)
  #   else
  #     order(created_at: :desc).joins(:pins).includes(:pins).limit(50)
  #   end
  # end
end
