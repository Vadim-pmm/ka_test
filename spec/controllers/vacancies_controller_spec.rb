require 'rails_helper'

describe VacanciesController do
  let!(:current_user) { User.create(name: 'Сидоров Иван Иванович', email: 'test@example.com', password: '1') }

  before :each do
    sign_in current_user
  end

  after :each do
    sign_out :user
  end

  describe 'POST #append_skill' do

    it 'adds new skill' do
      v = Vacancy.create(name: 'Тестовая вакансия', expires_at: 2.days.from_now, salary: 5000, contact_info: 'нет')
      session[:vac_id] = v.id

      post :append_skill, xhr: true, params: {newskill: 'Новый навык'}

      v = Vacancy.find(session[:vac_id])
      expect(v.skills.length).to eq(1)
    end

    it 'doesnt add duplicates to skill' do
      NEW_NAME = 'Новый навык'
      new_skill = [Skill.create(name: NEW_NAME).id]
      # create vacancy with one skill
      v = Vacancy.create(name: 'Тестовая вакансия', expires_at: 2.days.from_now, salary: 5000,
                         contact_info: 'нет', skills: new_skill)
      session[:vac_id] = v.id
      # try to add another skill with the same name
      post :append_skill, xhr: true, params: {newskill: NEW_NAME}

      v = Vacancy.find(session[:vac_id])
      expect(v.skills.length).to eq(1)
    end

    it 'is able to find skills by name'

    it 'excludes duplicate vacancy name' do
      @vacancy = Vacancy.new(name: 'Тестовая вакансия', expires_at: Date.today, salary: 5000, contact_info: 'Нет')
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
      session['vac_id'] = 1
      post :update, params: {id: @vacancy.id, vacancy: {name: 'Тестовая вакансия', expires_at: Date.today, salary: 5000, contact_info: 'Нет'}}
      expect(session['vac_id']).to be_nil
    end
  end

end