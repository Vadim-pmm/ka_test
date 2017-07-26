class VacanciesController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :get_vacancy, only: [:show, :edit, :update, :search_for_candidates]

  def index
    @vacancies = Vacancy.not_expired
  end

  def show
    @comments = @vacancy.comments
  end

  def new
    @vacancies = Vacancy.all.order(id: :desc)
  end

  def create
    flash[:notice] = 'Успешно создана' if Vacancy.create(name: params[:name])
    redirect_to new_vacancy_path
  end

  def edit
    session[:vac_id] = params[:id]
  end

  def update
    @vacancy.update(params_permitted)

    session[:vac_id] = nil
    redirect_to new_vacancy_path
  end

  def destroy
    Vacancy.delete(params[:id])
    redirect_to vacancies_path
  end

  def append_skill
    @skill_added = Skill.find_or_create_by(name: params[:newskill].strip)

    @vacancy = Vacancy.find(session[:vac_id])

    skills_ = @vacancy.skills
    skills_names = Skill.get_skills_names(skills_)

    if skills_names.include? @skill_added.name
      @skill_added = nil
    else
      @vacancy.update(skills: (skills_ << @skill_added.id).uniq.sort)
    end

    respond_to do |format|
      format.js
    end
  end

  def remove_skill
    @vacancy = Vacancy.find(session[:vac_id])
    @vacancy.update(skills: @vacancy.skills.reject {|item| item == params[:id].to_i})

    respond_to do |format|
      format.js
    end
  end

  def search_for_candidates
    search_criteria = @vacancy.skills.sort

    selected_profiles = Profile.only_active.reject { |item| item.skills != search_criteria }
    @search_result_exact = User.where(id: selected_profiles)
    selected_profiles = Profile.only_active.reject { |item| ((item.skills & search_criteria).length == 0) || (item.skills == search_criteria) }

    @search_result_not_exact = User.where(id: selected_profiles)
  end

  private

  def params_permitted
    params.require(:vacancy).permit(:name, :expires_at, :salary, :contact_info)
  end

  def get_vacancy
    @vacancy = Vacancy.find(params[:id])
  end

end