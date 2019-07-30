class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  belongs_to :company

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
end