class Race

  @@AVAILABLE_RACES = ["human","elf","dwarf","orc","goblin"]

  attr_accessor :str
  attr_accessor :agi
  attr_accessor :initialize

  def initialize(race="human")
    case race
    when "human" then setAttributes(3,3,4,100,100,"human")
    when "elf" then setAttributes(2,4,4,60,140,"elf")
    when "dwarf" then setAttributes(6,2,2,150,50,"dwarf")
    when "orc" then setAttributes(7,2,1,180,20,"orc")
    when "goblin" then setAttributes(3,4,3,80,120,"goblin")
    end
  end

  private
  def setAttributes(str,agi,int,health,mana,race_name)
    @str = str
    @agi = agi
    @int = int
    @health = health
    @HEALTH_MAX = health
    @mana = mana
    @MANA_MAX = mana
    @race_name = race_name
  end

  def self.getAvailableRaces
    return @@AVAILABLE_RACES
  end

  def raceInfo
    return "Race: #{@race_name.capitalize}\n***Stats***\nHealth: #{@health}/#{@HEALTH_MAX}\nMana: #{@mana}/#{@MANA_MAX}\nStrength: #{@str}\nAgility: #{@agi}\nIntelligence: #{@int}\n"
  end
end
