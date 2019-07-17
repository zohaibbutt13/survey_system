class Question < ActiveRecord::Base
	belongs_to :survey
	has_many :options
	has_many :responses

  validates :detail, presence: true, length: { maximum: 100 }
end
