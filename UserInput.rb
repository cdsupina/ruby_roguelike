load 'Races.rb'
load 'Skills.rb'

module UserInput #Provides methods for recieving user input

  include Skills

  ###CHARACTER CREATION
  def getName #Recieves and processes the name given by the user

    puts "Enter the name of your character."

    name = gets.chomp.to_s
    words_in_name = name.split(" ")
    name = ""

    words_in_name.each do |i|
      i.capitalize!
      name += "#{i} "
    end

    name.chomp!(" ")
    return name
  end


  def getRace #Recieves and processes the race given by the user

    puts "Enter the race of your character. Available races are #{Race.getAvailableRaces}."

      begin
        race = gets.chomp.downcase
        if !Race.getAvailableRaces.include? race
          raise UserInputError, "#{race} is not an available race."
        end
      rescue Exception => ex
        puts ex.message
        retry
      end

    return race
  end


  def getSkill(start=false) #Recieves and processes the skill given by the user

    if start
      puts "Enter the starting skill of your character. Available skills are #{@@AVAILABLE_COMBAT_SKILLS}."

      begin
        skill = gets.chomp.downcase
        if !@@AVAILABLE_COMBAT_SKILLS.include? skill
          raise UserInputError, "#{skill} is not an available skill."
        end
      rescue Exception => ex
        puts ex.message
        retry
      end

    else
      puts "Enter the desired skill to aquire."
    end

    return skill
  end


  #ACTION METHODS
  AVAILABLE_ACTIONS = ["up","w","down","s","left","a","right","d","map","help","info","exit"]


  def getAction(user,room,map)
    print "\nEnter an action:"

    begin
      action = gets.chomp.downcase
      if !AVAILABLE_ACTIONS.include? action
        raise UserInputError, "#{action} is not an available action."
      end
    rescue Exception => ex
      puts ex.message
      retry
    end

    case action
    when "up" then moveUp(user,room,map)
    when "w" then moveUp(user,room,map)
    when "down" then moveDown(user,room,map)
    when "s" then moveDown(user,room,map)
    when "left" then moveLeft(user,room,map)
    when "a" then moveLeft(user,room,map)
    when "right" then moveRight(user,room,map)
    when "d" then moveRight(user,room,map)
    when "map" then showMap(user,map)
    when "help" then help
    when "info" then info(user)
    when "exit" then endGame
    end

    Room.setCurrentRoom(user.current_room)
  end

  private
  def moveUp(user,room,map)
    currentLoc = user.location
    if areSameCoordinates(currentLoc,room.in) && user.current_room != 0
      user.iterCurrentRoom(-1)
      user.location = map.rooms[user.current_room].out
    elsif currentLoc[1]>0
      nextLoc = [currentLoc[0],currentLoc[1]-1]
      user.location = nextLoc
    end
    moveEnemy(room)
  end

  private
  def moveDown(user,room,map)
    currentLoc = user.location
    if areSameCoordinates(currentLoc,room.out)
      if map.rooms[user.current_room+1] == nil
        map.addRoom
      end
      user.iterCurrentRoom(1)
      user.location = map.rooms[user.current_room].in
    elsif currentLoc[1]<room.width-1
      nextLoc = [currentLoc[0],currentLoc[1]+1]
      user.location = nextLoc
    end
    moveEnemy(room)
  end

  private
  def moveLeft(user,room,map)
    currentLoc = user.location
    if currentLoc[0] > 0
      nextLoc = [currentLoc[0]-1,currentLoc[1]]
      user.location = nextLoc
    end
    moveEnemy(room)
  end

  private
  def moveRight(user,room,map)
    currentLoc = user.location
    if currentLoc[0]<room.length-1
      nextLoc = [currentLoc[0]+1,currentLoc[1]]
      user.location = nextLoc
    end
    moveEnemy(room)
  end

  def moveEnemy(room)
    room.enemy_locations.each do |enemy|
      enemy[2].step(room)
      enemy[0] = enemy[2].location[0]
      enemy[1] = enemy[2].location[1]
    end
    room.enemy_locations.sort_by! {|x,y| [y,x]}
  end

  def showMap(user,map)
    print "####################-Map-####################"
    map.displayMap(user)
    print "########################################"
  end

  def help
    print "These are the available actions: #{AVAILABLE_ACTIONS}."
  end

  private
  def info(user)
    print user.characterInfo
  end

  private
  def endGame
    abort
  end

  def areSameCoordinates(coor1,coor2)
    #puts "COORDINATES: #{coor1},#{coor2}"
    if coor1[0] == coor2[0] && coor1[1]==coor2[1]
      return true
    else
      return false
    end
  end

end




class UserInputError < StandardError #Handles error for not entering expected input
  def initialize(msg="You entered an unavailable option.")
    super
  end
end
