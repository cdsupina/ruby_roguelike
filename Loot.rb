class Item

  @@AVAILABLE_ITEMS = {

    "potion" => [["mana potion",50],["health potion",50]],
    "food" => [["apple",5],["cheese",15],["tart",10],["tea", 3]]
  }

  attr_reader :item

  def initialize
    type_idx = rand(@@AVAILABLE_ITEMS.keys.length)
    @type = @@AVAILABLE_ITEMS.keys[type_idx]
    item_idx = rand(@@AVAILABLE_ITEMS[@type].length)
    @item = @@AVAILABLE_ITEMS[@type][item_idx][0]
    @value = @@AVAILABLE_ITEMS[@type][item_idx][1]
  end

  def displayItemDescription
    return "\nType: #{@type.capitalize}\nItem: #{@item.capitalize}\nValue: #{@value}gp"
  end
end


class SpecificItem < Item
  def initialize(type="food",item=0)
    @type = type
    @item = @@AVAILABLE_ITEMS[type][item][0]
    @value = @@AVAILABLE_ITEMS[type][item][1]
  end
end
