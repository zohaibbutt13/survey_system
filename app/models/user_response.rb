class UserResponse < ActiveRecord::Base
  belongs_to :user
  belongs_to :survey
  has_many :answers, inverse_of: :user_response

  accepts_nested_attributes_for :answers
end
