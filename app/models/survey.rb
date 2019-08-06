require 'will_paginate/array'
require 'date'

class Survey < ActiveRecord::Base
  CATEGORIES = ['Community', 'Customer Feedback', 'Customer Satisfaction', 'Demographics', 
                'Education', 'Events', 'Healthcare', 'Human Resources', 'Just for Fun',
                'Political', 'Quiz', 'Other']

  has_many :activities, as: :trackable
  belongs_to :user
  has_many :questions, dependent: :destroy, inverse_of: :survey, autosave: true
  has_many :options, through: :questions
  accepts_nested_attributes_for :questions
  accepts_nested_attributes_for :options
  belongs_to :company
  has_many :user_responses, dependent: :destroy, inverse_of: :survey

  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 500 }

  before_save :mark_question_for_removal

  default_scope { where(company_id: Company.current_id) }
  scope :public_surveys, -> { where(survey_type: 'public') }
  scope :expired_surveys, -> { where('expiry < ?', DateTime.now) }
  scope :active_surveys, -> { where('expiry > ?', DateTime.now) }

  # Returns array of all the public surveys
  def self.get_public_surveys(page_params, per_page_limit)
    Survey.public_surveys.paginate(page: page_params, per_page: per_page_limit)
  end

  def self.get_expired_surveys
    Survey.expired_surveys
  end

  def self.get_active_surveys
    Survey.active_surveys
  end

  def mark_question_for_removal
    questions.each do |question|
      question.mark_for_destruction if question.statement == '-1'
    end
  end
  
  def self.save?(survey)
    survey.save
  end
end
