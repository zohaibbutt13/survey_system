class Option < ActiveRecord::Base
  belongs_to :question, inverse_of: :options
  belongs_to :company

  validates :detail, presence: true, length: { maximum: 100 }, if: :multiple_options?

  def multiple_options?
    question.question_type == 'Checkbox' || question.question_type == 'Radio Buttons'
  end
end
