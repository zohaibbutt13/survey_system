class Survey < ActiveRecord::Base
  include Trackable
  belongs_to :user
  has_many :questions
  belongs_to :company

  validates :name, presence: true, length: { maximum: 20 }
  validates :description, presence: true, length: { maximum: 150 }

  # Returns array of all the public surveys
  def self.get_public_surveys
    @surveys = Array[]
    Survey.where(type: 'public').find_each do |survey|
      @surveys.push(survey)
    end
    # Update: Currently there are no surveys in db
    # So remove the following hard cored array after adding data to db
    @surveys = ['survey1', 'survey2', 'survey3',
                'survey4', 'survey5', 'survey6',
                'survey7', 'survey8']
    @surveys
  end
end
