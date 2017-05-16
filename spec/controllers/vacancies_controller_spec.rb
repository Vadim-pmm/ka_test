require 'rails_helper'

describe VacanciesController do

  before :each do
    user = User.create(name: 'Сидоров Иван Иванович', email: 's@example.com', password: '1')
    session[:user_id] = user.id
    # user.confirm!
    sign_in user
  end

  describe 'GET #append_skill' do
    it 'always find or create new skill' do
      session['vac_id'] = 1

      post :append_skill, xhr: true, params: {newskill: 'Новый навык'}
      expect(assigns['skill_added']).not_to be_nil
    end

    it 'is able to find skills by name'

    it 'excludes duplicate vacancy name' do
      @vacancy = Vacancy.new(name: 'Тестовая вакансия', expires_at: Date.today, salary: 5000, contact_info: 'Не предоставлено')
      @skill = Skill.create(name: 'Тестовый скилл')
      @vacancy.skills << @skill.id
      @vacancy.save

      session['vac_id'] = @vacancy.id
      post :append_skill, xhr: true, params: {newskill: 'Тестовый скилл'}
      expect(Vacancy.find(session['vac_id']).skills.count).to eq(1)

    end
  end

  describe 'POST #update' do
    it 'has to clear current vacancy id' do
      @vacancy = Vacancy.create(name: 'Тестовая вакансия')

      post :update, params: {id: @vacancy.id, vacancy: {name: 'Тестовая вакансия', expires_at: Date.today, salary: 5000, contact_info: 'Не предоставлено'}}
      expect(session['vac_id']).to be_nil
    end
  end

end