class Response < ActiveRecord::Base
  has_many :activities, as: :trackable
  belongs_to :question
  belongs_to :company
end