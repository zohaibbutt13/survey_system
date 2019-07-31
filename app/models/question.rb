class Question < ActiveRecord::Base
  belongs_to :survey, inverse_of: :questions
  has_many :options, dependent: :destroy, inverse_of: :question, autosave: true
  accepts_nested_attributes_for :options
  has_many :answers, dependent: :destroy
  belongs_to :company

  validates :statement, presence: true, length: { maximum: 100 }
  before_save :mark_option_for_removal

  def mark_option_for_removal
    options.each do |option|
      option.mark_for_destruction if option.detail == 'nill'
    end
  end
end