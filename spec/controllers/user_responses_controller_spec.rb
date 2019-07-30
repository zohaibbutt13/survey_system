require 'rails_helper'

RSpec.describe UserResponsesController, type: :controller do
  it 'renders the index template' do
    get :index, survey_id: 66
    expect(response).to render_template('index')
  end

  it 'renders the new template' do
    get :new, survey_id: 66
    expect(response).to render_template('new')
  end

  it 'renders the show template' do
    get :new, survey_id: 66
    expect(response).to render_template('show')
  end

end
