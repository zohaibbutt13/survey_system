class Survey < ActiveRecord::Base
  belongs_to :user
  has_many :questions, dependent: :destroy, inverse_of: :survey, autosave: true
  has_many :options, :through => :questions
  accepts_nested_attributes_for :questions
  accepts_nested_attributes_for :options
  belongs_to :company

  validates :name, presence: true, length: { maximum: 20 }
  validates :description, presence: true, length: { maximum: 150 }
  before_save :mark_question_for_removal

  def mark_question_for_removal
    questions.each do |question|
      question.mark_for_destruction if question.statement == '-1'
    end
  end
end
