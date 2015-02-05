class Like < ActiveRecord::Base
  belongs_to :user
  belongs_to :pin

  validates_uniqueness_of :pin_id, scope: :user_id
end
