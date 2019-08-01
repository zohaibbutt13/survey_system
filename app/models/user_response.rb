require 'will_paginate/array'

class UserResponse < ActiveRecord::Base
  belongs_to :user
  belongs_to :survey
  has_many :answers, inverse_of: :user_response, dependent: :destroy

  accepts_nested_attributes_for :answers

  def self.response_per_page(user_responses, page_params, per_page_limit)
    user_responses.paginate(page: page_params, per_page: per_page_limit)
  end

end
