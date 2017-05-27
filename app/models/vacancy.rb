class Vacancy < ApplicationRecord
  scope :not_expired, -> { where("expires_at >= ?", Date.today).order(id: :desc) }

  has_many :comments

  def get_skills_by_name(skills_id)
    Skill.where(id: skills_id).pluck(:name)
  end

end
