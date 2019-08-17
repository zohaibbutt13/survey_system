require 'will_paginate/array'

class UserResponse < ActiveRecord::Base
  has_many :activities, as: :trackable
  belongs_to :user
  belongs_to :survey
  belongs_to :company
  has_many :answers, inverse_of: :user_response, dependent: :destroy

  accepts_nested_attributes_for :answers

  after_create :create_response_activity

  def self.response_per_page(user_responses, page_params, per_page_limit)
    user_responses.paginate(page: page_params, per_page: per_page_limit)
  end

  def create_response_activity
    if user_id.nil?
      false
    else
      Activity.create(trackable: self, action: 'submitted', owner_id: user_id, company_id: company_id)
    end
  end
end
