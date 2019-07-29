require 'will_paginate/array'

class Survey < ActiveRecord::Base
  has_many :activities, as: :trackable
  belongs_to :user
  has_many :questions
  belongs_to :company

  validates :name, presence: true, length: { maximum: 20 }
  validates :description, presence: true, length: { maximum: 150 }

  scope :public_surveys, -> { where(survey_type: 'public') }

  # Returns array of all the public surveys
  def self.get_public_surveys(page_params, per_page_limit)
    surveys = Survey.public_surveys.paginate(page: page_params, per_page: per_page_limit)
  end
end