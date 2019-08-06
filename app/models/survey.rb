require 'will_paginate/array'
require 'date'

class Survey < ActiveRecord::Base
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
  scope :latest_surveys, -> { order('surveys.created_at desc') }

  # Returns array of all the public surveys
  def self.get_public_surveys(page_params, per_page_limit)
    Survey.public_surveys.paginate(page: page_params, per_page: per_page_limit)
  end

  # Returns an array having surveys respones count
  def self.latest_surveys_responses(count)
    latest_surveys.limit(count)
                  .joins('LEFT OUTER JOIN user_responses on surveys.id = user_responses.survey_id')
                  .select('COUNT(user_responses.id) AS responses_count')
                  .group('surveys.id')
                  .map { |survey| survey.responses_count }
  end

  def mark_question_for_removal
    questions.each do |question|
      question.mark_for_destruction if question.statement == '-1'
    end
  end
end
