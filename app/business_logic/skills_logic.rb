class CheckSkills
  def self.skill_in_use?(id_)
    a = Vacancy.where("? = ANY(skills)", id_).count
    b = Profile.where("? = ANY(skills)", id_).count
    (a + b) != 0
  end
end
