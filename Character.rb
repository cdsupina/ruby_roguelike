
load 'Races.rb'
load 'Skills.rb'


class Player < Race

  include Skills

  attr_accessor :current_room
  attr_accessor :location

  def initialize(name, race, skill)
    @name = name
    @current_room = 0
    @location = [nil,nil]
    @skills = {}
    @@AVAILABLE_COMBAT_SKILLS.each do |x|
      @skills[x] = [false, 0]
    end
    @skills[skill] = [true, 1]
    @loot = []
    super(race)
  end

  def characterInfo
    return "##########Info##########\n***Character***\nName: #{@name}\n" + raceInfo + skillInfo + locationInfo + "\n***Loot***\n#{lootString}\n####################"
  end

  def skillInfo
    skill_output = "***Skills***"

    @skills.each do |skill,aquired|
      if aquired[0]
        skill_output += "\n#{skill.capitalize}: lvl#{aquired[1]}, "
      end
    end

    return skill_output.chomp(", ")
  end

  def locationInfo
    return "\n***Map***\nLocation: #{@location}"
  end

  def addLoot(item)
    @loot.push(item)
  end

  def lootString
    return_string = ""
    i = 1
    @loot.each do |x|
      return_string += "#{i}. #{x.item}\n"
      i+=1
    end

    return return_string.chomp("\n")
  end

  def iterCurrentRoom(direction)
    @current_room += direction
  end
end
