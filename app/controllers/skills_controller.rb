class SkillsController < ApplicationController
  before_action :authenticate_user!

  def new
    @skill = Skill.new
    @skills = Skill.all.order(id: :desc)
  end

  def create
    skill = Skill.new(params_permitted)
    skill.accepted = true
    flash[:notice] = 'Ошибка записи' unless skill.save

    redirect_to new_skill_path
  end

  def accept
    skill = Skill.find(params[:id])
    flash[:notice] = 'Ошибка записи' unless skill.update(accepted: true)

    redirect_to new_skill_path
  end

  def destroy
    if skill_in_use?(params[:id])
      flash[:danger] = 'Данный навык используется в вакансии или в резюме'
    else
      Skill.delete(params[:id])
    end

    redirect_to new_skill_path
  end

  private

  def params_permitted
    params.require(:skill).permit(:name)
  end

  def skill_in_use?(id_)
    a = Vacancy.where("? = ANY(skills)", id_).count
    b = Profile.where("? = ANY(skills)", id_).count
    (a + b) != 0
  end
end
