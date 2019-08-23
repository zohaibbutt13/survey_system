require 'will_paginate/array'
require 'date'

class Survey < ActiveRecord::Base
  CATEGORIES = ['Community', 'Customer Feedback', 'Customer Satisfaction', 'Demographics', 
                'Education', 'Events', 'Healthcare', 'Human Resources', 'Just for Fun',
                'Political', 'Quiz', 'Other']

  has_many :activities, as: :trackable
  belongs_to :user
  has_many :questions, dependent: :destroy, autosave: true
  has_many :options, through: :questions
  belongs_to :company
  has_many :user_responses, dependent: :destroy
  belongs_to :group

  accepts_nested_attributes_for :questions, :options

  validates :name, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :expiry, presence: true
  validate :verify_group
  validates_inclusion_of :survey_type, in: [ 'Private', 'Public'], message: "Survey type %s is incorrect"

  before_save :mark_question_for_removal
  after_create :create_survey_activity
  after_update :update_survey_activity
  after_destroy :destroy_survey_activity

  default_scope { where(company_id: Company.current_id) }
  scope :public_surveys, -> { where(survey_type: 'public') }
  scope :expired_surveys, -> { where('expiry < ?', DateTime.now) }
  scope :active_surveys, -> { where('expiry > ?', DateTime.now) }
  scope :latest_surveys, -> { order('surveys.created_at desc') }

  def verify_group
    groups_id = Group.all.collect{ |g| g.id }
    groups_id << 0
    if !groups_id.include? group_id
      errors.add(:group_id, 'value is incorrect')
    end
  end

  # Returns array of all the public surveys
  def self.get_public_surveys(page_params, per_page_limit, category=nil)
    if Company.current_id.nil?
      if category.nil?
        Survey.unscoped.public_surveys.paginate(page: page_params, per_page: per_page_limit)
      else
        Survey.unscoped.public_surveys.where(category: category).paginate(page: page_params, per_page: per_page_limit)
      end
    else
      if category.nil?
        Survey.public_surveys.paginate(page: page_params, per_page: per_page_limit)
      else
        Survey.public_surveys.where(category: category).paginate(page: page_params, per_page: per_page_limit)
      end
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
