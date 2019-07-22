class Response < ActiveRecord::Base
  include Trackable
  belongs_to :question
  belongs_to :company
end
