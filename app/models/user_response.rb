require 'will_paginate/array'

class UserResponse < ActiveRecord::Base
  has_many :activities, as: :trackable
  belongs_to :user
  belongs_to :survey
  belongs_to :company
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers

  after_create :create_response_activity
  validate :required_question_answer, :check_guest_user_email

  scope :response_for_public_surveys, -> (s_id) { where('survey_id = ?', s_id) }

  def check_guest_user_email
    if (user_id.blank? && email.blank?)
      errors.add(:email, I18n.t('user_responses.email_empty_error'))
    end
  end

  def required_question_answer
    questions = survey.questions
    index = 0
    answers.each do |answer|
      question = questions[index]
      if question.question_type == COMMENTBOX
        if question.required && answer.detail.blank?
          errors.add(:detail, I18n.t('user_responses.detail_empty_error'))
        end
      else
        if question.required && answer.option_id.blank?
          errors.add(:detail, I18n.t('user_responses.detail_empty_error'))
        end
      end
      index += 1
    end
  end

  def create_response_activity
    Activity.create(trackable: self, action: 'created', owner_id: user_id, company_id: company_id)
  end

  def self.get_public_responses(survey_id, page_params, per_page_limit)
    UserResponse.unscoped.response_for_public_surveys(survey_id).paginate(page: page_params, per_page: per_page_limit)
  end
end
