class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :questions
  belongs_to :company

  validates :name, presence: true, length: { maximum: 20 }
  validates :description, presence: true, length: { maximum: 150 }
end
