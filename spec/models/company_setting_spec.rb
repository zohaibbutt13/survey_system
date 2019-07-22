require 'rails_helper'

RSpec.describe CompanySetting, type: :model do
  context 'validation tests' do
    it 'ensures max questions range' do
      c_settings = CompanySetting.new(is_my_settings_sup: '1', is_my_settings_memb: '1', is_sup_create_surv: '1', is_sup_edit_surv: '1', max_questions: '500').save
      expect(c_settings).to eq(false)
    end
  end
end