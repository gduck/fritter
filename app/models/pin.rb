class Pin < ActiveRecord::Base
  validates :pinterest_id, uniqueness: true
  validates :source_url,  presence: true #this is the original src url
  validates :like_count, numericality: true
  validates :category_id, presence: true

  belongs_to :category

  def self.search(search)
    if search
      joins(:pin).where('(pin.title || pin.optional_info) LIKE ?', "%#{search}").includes(:pin)
    else
      order(created_at: :desc)
    end
  end
end
