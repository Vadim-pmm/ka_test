class CandidatesController < ApplicationController
  before_action :authenticate_user!

  def index
    @candidates = User.all_active
  end

  def show
    @candidate = User.find(params[:id])
    @profile = Profile.find_by(user_id: @candidate.id)
  end

  def edit
    @candidate = current_user
    @profile = Profile.find_or_create_by(user_id: @candidate.id)
  end

  def update
    params_permitted
    if current_user.profile.update(address: params[:profile][:address],
                                   salary: params[:profile][:salary],
                                   phone: params[:profile][:phone],
                                   act: looking_for_job?)
      flash[:notice] = 'Профиль успешно обновлен'
      redirect_to root_path
    else
      flash[:danger] = 'Проверьте значения полей'
      redirect_to edit_candidate_path(current_user.id)
    end

  end

  def append_skill
    @skill_added = Skill.find_or_create_by(name: params[:newskill].strip)

    skills_      = current_user.profile.skills
    skills_names = current_user.get_skills_by_name(skills_)

    if skills_names.include?(@skill_added.name)
      @skill_added = nil
    else
      current_user.profile.update(skills: (skills_ << @skill_added.id).uniq.sort)
    end

    respond_to do |format|
      format.js
    end
  end

  def remove_skill
    current_user.profile.update(skills: current_user.profile.skills.reject {|item| item == params[:id].to_i})

    respond_to do |format|
      format.js
    end
  end

  def search_for_vacancies
    search_criteria = current_user.profile.skills.sort

    case params[:dest]
      when 'exact'
        @search_result = Vacancy.not_expired.reject { |item| item.skills != search_criteria }
      when 'not_exact'
        get_data = Vacancy.not_expired
        @search_result = []
        get_data.each do |item|
          @search_result << item if ((item.skills & search_criteria).length != 0)
        end
      else
        @search_result = Vacancy.not_expired.map
    end

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def params_permitted
    params.require(:profile).permit(:address, :salary, :act, :phone)
  end

  def looking_for_job?
    params[:profile][:act] == '0' ? false : true
  end
end
