class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  # validates :username, presence: true, uniqueness: true

  # missing relationship info
  has_many :likes
  has_many :pins, through: :likes
end
