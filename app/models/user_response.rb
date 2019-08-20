require 'will_paginate/array'

class UserResponse < ActiveRecord::Base
  has_many :activities, as: :trackable
  belongs_to :user
  belongs_to :survey
  belongs_to :company
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers

  after_create :create_response_activity
  validate :required_question, :check_guest_user_email

  def check_guest_user_email
    if (user_id.nil? && email.blank?)
      errors.add(:email, I18n.t('user_responses.email_empty_error'))
    end
  end

  def required_question
    answers.each do |answer|
      question = Question.find(answer.question_id)
      if question.question_type == 'Comment Box'
        if question.required && answer.detail.blank?
          errors.add(:detail, 'can not be blank')
        end
      else
        if question.required && answer.option_id.blank?
          errors.add(:detail, 'can not be blank')
        end
      end
    end
  end

  def create_response_activity
    Activity.create(trackable: self, action: 'created', owner_id: user_id, company_id: company_id)
  end
end
