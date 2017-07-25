class Skill < ApplicationRecord

  def self.get_skills_names(skills_id)
    where(id: skills_id).pluck(:name)
  end

end
