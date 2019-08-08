require 'will_paginate/array'
require 'date'

class Survey < ActiveRecord::Base
  has_many :activities, as: :trackable
  belongs_to :user
  has_many :questions, dependent: :destroy, autosave: true
  has_many :options, through: :questions
  belongs_to :company
  has_many :user_responses, dependent: :destroy
  belongs_to :group

  accepts_nested_attributes_for :questions, :options

  validates :name, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  before_save :mark_question_for_removal

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
