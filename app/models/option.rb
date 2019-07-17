class Option < ActiveRecord::Base
	belongs_to :question

  validates :detail, presence: true, length: { maximum: 100 }
end
