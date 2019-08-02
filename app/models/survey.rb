require 'will_paginate/array'
require 'date'

class Survey < ActiveRecord::Base
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
  after_create :create_survey_activity
  after_update :update_survey_activity
  after_destroy :destroy_survey_activity

  default_scope { where(company_id: Company.current_id) }
  scope :public_surveys, -> { where(survey_type: 'public') }
  scope :expired_surveys, -> { where('expiry < ?', DateTime.now) }
  scope :active_surveys, -> { where('expiry > ?', DateTime.now) }

  # Returns array of all the public surveys
  def self.get_public_surveys(page_params, per_page_limit)
    Survey.public_surveys.paginate(page: page_params, per_page: per_page_limit)
  end

  # Returns an array having survey names
  def self.latest_surveys_names(count)
    survey_names = []
    Survey.last(count).each do |survey|
      survey_names.push(survey.name.to_s)
    end
    survey_names
  end

  # Returns an array having surveys respones count
  def self.latest_surveys_responses(count)
    survey_responses = []
    Survey.last(count).each do |survey|
      survey_responses.push(survey.user_responses.count)
    end
    survey_responses
  end

  def mark_question_for_removal
    questions.each do |question|
      question.mark_for_destruction if question.statement == '-1'
    end
  end

  def self.save?(survey)
    survey.save
  end

  def create_survey_activity
    Activity.create(trackable: self, action: 'created', owner_id: self.user_id, company_id: self.company_id)
  end

  def update_survey_activity
    Activity.create(trackable: self, action: 'updated', owner_id: self.user_id, company_id: self.company_id)
  end

  def destroy_survey_activity
    Activity.create(trackable: self, action: 'deleted', owner_id: self.user_id, company_id: self.company_id)
  end
end