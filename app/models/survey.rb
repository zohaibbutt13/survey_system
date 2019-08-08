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
  belongs_to :company
  has_many :user_responses, dependent: :destroy, inverse_of: :survey
  belongs_to :group, inverse_of: :survey

  accepts_nested_attributes_for :questions, :options

  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 500 }

  before_save :mark_question_for_removal
  after_create :create_survey_activity
  after_update :update_survey_activity
  after_destroy :destroy_survey_activity

  default_scope { where(company_id: Company.current_id) }
  scope :public_surveys, -> { where(survey_type: 'public') }
  scope :expired_surveys, -> { where('expiry < ?', DateTime.now) }
  scope :active_surveys, -> { where('expiry > ?', DateTime.now) }
  scope :latest_surveys, -> { order('surveys.created_at desc') }

  # Returns array of all the public surveys
  def self.get_public_surveys(page_params, per_page_limit, category=nil)
    if category.nil?
      Survey.unscoped.public_surveys.paginate(page: page_params, per_page: per_page_limit)
    else
      Survey.unscoped.public_surveys.where(category: category).paginate(page: page_params, per_page: per_page_limit)
    end
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

  def create_survey_activity
    Activity.create(trackable: self, action: 'created', owner_id: user_id, company_id: company_id)
  end

  def update_survey_activity
    Activity.create(trackable: self, action: 'updated', owner_id: user_id, company_id: company_id)
  end

  def destroy_survey_activity
    Activity.create(trackable: self, action: 'deleted', owner_id: user_id, company_id: company_id)
  end
end
