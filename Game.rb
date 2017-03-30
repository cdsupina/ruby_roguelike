load "Character.rb"
load 'UserInput.rb'
load 'Maps.rb'
load 'Loot.rb'

include UserInput

=begin
loot = Item.new()
print loot.displayItemDescription
=end
#=begin
player_name = getName
player_race = getRace
first_skill = getSkill(true)

#player_name = "Carlo"
#player_race = "elf"
#first_skill = "club"

user = Player.new(player_name, player_race, first_skill)
map = Map.new
user.location = map.rooms[user.current_room].in
#print user.characterInfo
#print room.displayRoomStats
map.rooms[user.current_room].displayRoom(user)


while true
  getAction(user,map.rooms[user.current_room],map)
  map.rooms[user.current_room].displayRoom(user)
  #print map.rooms[user.current_room].displayRoomStats
end
#=end
