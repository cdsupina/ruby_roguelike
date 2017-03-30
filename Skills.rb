module Skills
  @@AVAILABLE_COMBAT_SKILLS = ["slash","swipe","club","stab"]

  def attack(skill)
    case skill
    when "slash" then slash
    when "swipe" then swipe
    when "club" then club
    when "stab" then stab
    end
  end

  def slash
  end
  def swipe
  end
  def club
  end
  def stab
  end
end
