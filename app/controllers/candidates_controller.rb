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
    if current_user.profile.update(params_permitted.merge(act: looking_for_job?))
      flash[:notice] = 'Профиль успешно обновлен'
      redirect_to root_path
    else
      flash[:danger] = 'Проверьте значения полей'
      redirect_to edit_candidate_path(current_user.id)
    end

  end

  def append_skill
    @skill_added = Skill.find_or_create_by(name: params[:newskill].strip)

    skills       = current_user.profile.skills
    skills_names = Skill.get_skills_names(skills)

    if skills_names.include?(@skill_added.name)
      @skill_added = nil
    else
      current_user.profile.update(skills: (skills << @skill_added.id).uniq.sort)
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
    if current_user.has_profile?
      @search_result = Vacancy.get_vacancies(params[:dest], current_user.profile.skills.sort)

      respond_to do |format|
        format.html        # initial rendering when candidate goes to search page
        format.js          # updates page with the search results (after pushing Search button)
      end
    else
      flash[:danger] = 'Заполните профиль'
      redirect_to root_path
    end

  end

  private

  def params_permitted
    params.require(:profile).permit(:address, :salary, :act, :phone, :avatar)
  end

  def looking_for_job?
    params[:profile][:act] == '0' ? false : true
  end
end
