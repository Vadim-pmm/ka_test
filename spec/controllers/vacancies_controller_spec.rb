require 'rails_helper'

describe VacanciesController do
  describe 'GET #append_skill' do
    it 'saves skills as ordered array' do
      session['vac_id'] = 1

      post :append_skill, xhr: true, params: {newskill: 'Новый навык'}
      expect(assigns['skill_added']).not_to be_nil
    end

    it 'is able to find skills by name'
    it 'excludes duplicate vacancy name'
  end
end