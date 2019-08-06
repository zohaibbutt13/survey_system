class Question < ActiveRecord::Base
  belongs_to :survey, inverse_of: :questions
  has_many :options, dependent: :destroy, inverse_of: :question, autosave: true
  accepts_nested_attributes_for :options
  has_many :answers, dependent: :destroy
  belongs_to :company

  validates :statement, presence: true, length: { maximum: 500 }

  before_save :mark_option_for_removal

  def mark_option_for_removal
    options.each do |option|
      option.mark_for_destruction if option.detail.nil?
    end
  end

  def answer_stats
    options.joins('LEFT OUTER JOIN answers on options.id = answers.option_id')
           .select('COUNT(answers.id) AS answers_count')
           .group('options.id')
           .map { |option| option.answers_count }
  end

  def options_labels
    options.pluck(:detail)
  end

  def checkbox?
    question_type == Question::QUESTION_TYPE[:checkbox]
  end

  def radiobutton?
    question_type == Question::QUESTION_TYPE[:radiobutton]
  end

  def boolean?
    question_type == Question::QUESTION_TYPE[:boolean]
  end

  def commentbox?
    question_type == Question::QUESTION_TYPE[:commentbox]
  end

  QUESTION_TYPE = { checkbox: 'Checkbox', radiobutton: 'Radio Buttons', boolean: 'True / False', commentbox: 'Comment Box' }
end
