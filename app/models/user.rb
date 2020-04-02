class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :books, dependent: :destroy

  def books
	  return Book.where(user_id: self.id)
  end

  attachment :profile_image

  validates :name, 
    presence: true,
    length: { minimum: 2, maximum: 20 }

  validates :email, 
    uniqueness: true,
    presence: true

  validates :introduction, 
  	length: { maximum: 50 }
end
