class ChangeSurveysidInUserResponses < ActiveRecord::Migration
  def change
    rename_column :user_responses, :surveys_id, :survey_id
  end
end
