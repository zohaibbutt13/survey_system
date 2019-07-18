class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :options
  has_many :responses
  belongs_to :company

  validates :detail, presence: true, length: { maximum: 100 }
end
