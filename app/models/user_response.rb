require 'will_paginate/array'

class UserResponse < ActiveRecord::Base
  has_many :activities, as: :trackable
  belongs_to :user
  belongs_to :survey
  belongs_to :company
  has_many :answers, dependent: :destroy

  accepts_nested_attributes_for :answers

  after_create :create_response_activity
  validate :check_guest_user_email

  def check_guest_user_email
    if (user_id.nil? && email.blank?)
      errors.add(:email, 'can not be empty')
    end
  end

  def create_response_activity
    Activity.create(trackable: self, action: 'created', owner_id: user_id, company_id: company_id)
  end
end
