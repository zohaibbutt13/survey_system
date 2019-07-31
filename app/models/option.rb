class Option < ActiveRecord::Base
  belongs_to :question, inverse_of: :options
  belongs_to :company
  has_many :answers, inverse_of: :option

  validates :detail, presence: true, length: { maximum: 500 }, if: :multiple_options?

  def multiple_options?
    question.question_type == 'Checkbox' || question.question_type == 'Radio Buttons'
  end

  def name_with_initialize
    "#{detail}"
  end
end
