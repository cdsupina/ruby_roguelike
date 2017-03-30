load 'Loot.rb'
load 'Enemy.rb'

class Room

  @@current_room = 0
  attr_reader :in
  attr_reader :out
  attr_reader :width
  attr_reader :length
  attr_reader :all_spawn_locations
  attr_accessor :enemy_locations


  def initialize(length_max = 10, width_max = 10, length_min = 5, width_min = 5)
    @length = length_min + rand(length_max-length_min+1)
    @width = width_min + rand(width_max-width_min+1)
    @area = @length*@width
    @in = [rand(@length-1),0]
    @out = [rand(@length-1),@width-1]

    @all_spawn_locations = generateAllSpawnLocations

    @loot_number = generateLootCount
    @loot_locations = generateLootLocations

    @enemy_number = generateEnemyCount
    @enemy_locations = generateEnemyLocations
  end

  def displayRoom(user)
    loot_spawned = 0
    enemies_spawned = 0
    loot_recieved = ""
    y_count = 0

    #puts "#{@@current_room},#{user.current_room}"
    print "\n"
    (2+@length*5).times do
      print "*"
    end

    @width.times do
      print "\n*"
      x_count = 0
      @length.times do

        if x_count == user.location[0] && y_count == user.location[1] && @@current_room == user.current_room
          if loot_spawned < @loot_number && x_count == @loot_locations[loot_spawned][0] && y_count == @loot_locations[loot_spawned][1]
            #loot_spawned += 1
            loot_recieved = "You got a #{@loot_locations[loot_spawned][2].item}"
            user.addLoot(@loot_locations[loot_spawned][2])
            @loot_locations.delete_at(loot_spawned)
            @loot_number -=1
          end

          if enemies_spawned < @enemy_number && x_count == @enemy_locations[enemies_spawned][0] && y_count == @enemy_locations[enemies_spawned][1]
            enemies_spawned += 1
          end

          print "[you]"
        elsif enemies_spawned < @enemy_number && x_count == @enemy_locations[enemies_spawned][0] && y_count == @enemy_locations[enemies_spawned][1]
          enemies_spawned += 1
          print "[ E ]"
        elsif loot_spawned < @loot_number && x_count == @loot_locations[loot_spawned][0] && y_count == @loot_locations[loot_spawned][1]
          loot_spawned += 1
          print "[ L ]"
        elsif x_count == @in[0] && y_count == @in[1]
          print "[i n]"
        elsif x_count == @out[0] && y_count == @out[1]
          print "[out]"
        else
          print "[   ]"
          #print "[#{x_count},#{y_count}]"
        end
        x_count += 1
      end
      print "*"
      y_count+= 1
    end
    print "\n"
    (2+@length*5).times do
      print "*"
    end
    print "\n#{loot_recieved}\n"
    #@@current_room = user.current_room


  end

  def displayRoomStats
    return "\nLength: #{@length}\nWidth: #{@width}\nEntrance: #{@entrance}\nExit: #{@exit}\nLoot: #{@loot_number}\nLoot Locations: #{@loot_locations}\nEnemies: #{@enemy_number}\nEnemy Locations: #{@enemy_locations}\nAll Spawn Locations #{@all_spawn_locations}"
  end

  def generateLootCount(base=60, loot=0)
    roll = rand(100)
    if(roll < base)
      loot=generateLootCount(base-10, loot+1)
    end
    #puts "#{@area},#{loot}"
    if loot > @area-2
      loot = @area-2
      #puts "#{@area},#{loot}"
    end
    return loot
  end

  def generateEnemyCount(base=80, loot=0)
    roll = rand(100)
    if(roll < base)
      loot=generateLootCount(base-10, loot+1)
    end
    #puts "#{@area},#{loot}"
    if loot > @area-2
      loot = @area-2
      #puts "#{@area},#{loot}"
    end
    return loot
  end

  def generateLootLocations
    loot_array_unsorted = []
    @loot_number.times do
      loc_candidate_idx = rand(@all_spawn_locations.length)
      loc_candidate= @all_spawn_locations[loc_candidate_idx]
      @all_spawn_locations.delete_at(loc_candidate_idx)
      loc_candidate.push(Item.new)
      loot_array_unsorted.push(loc_candidate)

      #puts  "ARRAY: #{loot_array_unsorted}"

    end

    return loot_array_unsorted.sort_by {|x,y| [y,x]}
  end

    def generateEnemyLocations
      enemy_array_unsorted = []
      @enemy_number.times do
        loc_candidate_idx = rand(@all_spawn_locations.length)
        loc_candidate= @all_spawn_locations[loc_candidate_idx]
        @all_spawn_locations.delete_at(loc_candidate_idx)


        loc_candidate.push(Enemy.new(loc_candidate,self,"human"))
        enemy_array_unsorted.push(loc_candidate)

        #puts  "ARRAY: #{enemy_array_unsorted}"

      end

    return enemy_array_unsorted.sort_by {|x,y| [y,x]}
  end

  def areSameCoordinates(coor1,coor2)
    #puts "COORDINATES: #{coor1},#{coor2}"
    if coor1[0] == coor2[0] && coor1[1]==coor2[1]
      return true
    else
      return false
    end
  end

  def self.iterCurrentRoom(direction)
    @@current_room += direction
  end

  def self.setCurrentRoom(num)
    @@current_room = num
  end

  def generateAllSpawnLocations
    locations = []
    y_count = 0
    @width.times do
      x_count = 0
      @length.times do
        coor = [x_count,y_count]
        if !areSameCoordinates(coor,@in) && !areSameCoordinates(coor,@out)
          locations.push(coor)
        end
        x_count += 1
      end
      y_count += 1
    end
    return locations
  end

end



class Map

  attr_reader :rooms

  def initialize
    @rooms = [Room.new]
  end

  def addRoom
    @rooms.push(Room.new)
  end

  def displayMap(user)

    Room.setCurrentRoom(0)

    @rooms.each do |x|
      x.displayRoom(user)
      Room.iterCurrentRoom(1)
    end
  end

end
