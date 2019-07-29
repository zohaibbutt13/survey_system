require 'will_paginate/array'
require 'date'

class Survey < ActiveRecord::Base
  has_many :activities, as: :trackable
  belongs_to :user
  has_many :questions
  belongs_to :company

  validates :name, presence: true, length: { maximum: 20 }
  validates :description, presence: true, length: { maximum: 150 }

  scope :public_surveys, -> { where(type: 'public') }
  scope :expired_surveys, ->(date_time) { where('expiry < ?', date_time) }
  scope :active_surveys, ->(date_time) { where('expiry > ?', date_time) }

  # Returns array of all the public surveys
  def self.get_public_surveys(page_params, per_page_limit)
    Survey.public_surveys.paginate(page: page_params, per_page: per_page_limit)
  end

  def self.get_expired_surveys
    Survey.expired_surveys(DateTime.now)
  end

  def self.get_active_surveys
    Survey.active_surveys(DateTime.now)
  end
end
