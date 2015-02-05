class Pin < ActiveRecord::Base
  validates :pinterest_id, uniqueness: true
  validates :source_url,  presence: true #this is the original src url
  validates :like_count, numericality: true
  validates :category_id, presence: true

  belongs_to :category
  has_many :likes, :dependent => :destroy
  has_many :users, through: :likes

end
