class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :company
  belongs_to :option
  belongs_to :user_response
end