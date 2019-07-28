class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :questions, dependent: :destroy
  has_many :options, through: :questions
  accepts_nested_attributes_for :questions
  accepts_nested_attributes_for :options
  belongs_to :company

  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 150 }

  def self.save?(survey)
    survey.save
  end
end
