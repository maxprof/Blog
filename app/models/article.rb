class Article < ActiveRecord::Base
	validates :title, :description, presence: true
	validates :title, length: {minimum: 5, maximum: 30}
	validates :description, length: {minimum: 10, maximum: 1000}
	validates :user_id, presence: true
	belongs_to :user
	has_many :article_categories
	has_many :categories, through: :article_categories

end
