class Answer < ActiveRecord::Base
  belongs_to :question
  belongs_to :company
  belongs_to :option, inverse_of: :answers
  belongs_to :user_response, inverse_of: :answers
end