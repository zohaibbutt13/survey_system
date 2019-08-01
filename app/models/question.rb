class Question < ActiveRecord::Base
  belongs_to :survey, inverse_of: :questions
  has_many :options, dependent: :destroy, inverse_of: :question, autosave: true
  accepts_nested_attributes_for :options
  has_many :answers
  belongs_to :company

  validates :statement, presence: true, length: { maximum: 100 }
  before_save :mark_option_for_removal

  def mark_option_for_removal
    options.each do |option|
      option.mark_for_destruction if option.detail == 'nill'
    end
  end

  def answer_stats
    stats_data = []
    options.each do |option|
      option_count = 0
      answers.each do |answer|
        option_count += 1 if answer.option_id == option.id
      end
      stats_data.push(option_count)
    end
    stats_data
  end

  def options_labels
    labels = []
    options.each do |option|
      labels.push(option.detail.to_s)
    end
    labels
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
