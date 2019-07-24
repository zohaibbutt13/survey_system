require 'will_paginate/array'

class Survey < ActiveRecord::Base
  include Trackable
  belongs_to :user
  has_many :questions
  belongs_to :company

  validates :name, presence: true, length: { maximum: 20 }
  validates :description, presence: true, length: { maximum: 150 }

  scope :public_surveys, -> { where(type: 'public') }

  # Returns array of all the public surveys
  def self.get_public_surveys(page_params, per_page_limit)
    surveys = Survey.public_surveys
    # Currently there are no surveys in db
    # So surveys can be blank, therefore provided default surveys 
    if surveys.blank?
      surveys = [{ name: 'survey1', description: " Survery 1 description here" },
                 { name: 'survey2', description: " Survery 2 description here" },
                 { name: 'survey3', description: " Survery 3 description here" },
                 { name: 'survey4', description: " Survery 4 description here" },
                 { name: 'survey5', description: " Survery 5 description here" },
                 { name: 'survey6', description: " Survery 6 description here" },
                 { name: 'survey7', description: " Survery 7 description here" },
                 { name: 'survey8', description: " Survery 8 description here" }
                ].paginate(page: page_params, per_page: per_page_limit)
    end
    surveys
  end
end