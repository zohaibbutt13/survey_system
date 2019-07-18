class Option < ActiveRecord::Base
  belongs_to :question
  belongs_to :company
  
  validates :detail, presence: true, length: { maximum: 100 }
end
