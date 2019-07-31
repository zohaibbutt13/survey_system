class Question < ActiveRecord::Base
  belongs_to :survey
  has_many :options, dependent: :destroy
  accepts_nested_attributes_for :options
  has_many :responses
  belongs_to :company

  validates :statement, presence: true, length: { maximum: 500 }
end