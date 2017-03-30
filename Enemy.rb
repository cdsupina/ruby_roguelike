load 'Races.rb'

class Enemy < Race

  attr_reader :location

  def initialize(loc,room,race)

    @location = loc
    @next_location = generateNextLocation(room)
    #@room_number = room_number
    super(race)
  end

  def generateNextLocation(room)
    directions = [0,1,2,3,4]
    direction_chosen = false
    next_location = @location
    while (!direction_chosen)
      directions_idx = rand(directions.length)

      case directions[directions_idx]
      when 0
        direction_chosen = true
      when 1
        location_candidate = [@location[0]+1,@location[1]]
        if room.all_spawn_locations.include? location_candidate
          next_location = location_candidate
          direction_chosen = true
        else
          directions.delete_at(1)
        end
      when 2
        location_candidate = [@location[0]-1,@location[1]]
        if room.all_spawn_locations.include? location_candidate
          next_location = location_candidate
          direction_chosen = true
        else
          directions.delete_at(2)
        end
      when 3
        location_candidate = [@location[0],@location[1]+1]
        if room.all_spawn_locations.include? location_candidate
          next_location = location_candidate
          direction_chosen = true
        else
          directions.delete_at(3)
        end
      when 4
        location_candidate = [@location[0],@location[1]-1]
        if room.all_spawn_locations.include? location_candidate
          next_location = location_candidate
          direction_chosen = true
        else
          directions.delete_at(4)
        end
      end

    end

    return next_location
  end

  def step(room)
    @location = @next_location
    @next_location = generateNextLocation(room)
  end
end
