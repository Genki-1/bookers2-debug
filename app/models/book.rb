class Book < ApplicationRecord

	belongs_to :user

	def books
	  return Book.find_by(user_id: self.id)
	end

	validates :title, presence: true

	validates :body, 
		presence: true, 
		length: { maximum: 199 }
end
