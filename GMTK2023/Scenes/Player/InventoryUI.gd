extends GridContainer

var rows := 6
var slots := columns * rows

@export var itemButton := preload("res://Scenes/Items/ItemIcon.tscn")

@onready var inventory := get_node("/root/GameLogic/Player/Inventory")

signal itemButtonPressed(itemName)

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in slots:
		var instance = itemButton.instantiate()
		instance.setName("DefaultItem")
		instance.itemButtonPressed.connect(_itemButtonPressed)
		add_child(instance)
	inventory.item_added.connect(_item_added)

func _item_added(itemName):
	var inventory_spot = getItem("DefaultItem") # search for empty spot
	inventory_spot.setName(itemName)

func getItem(itemName: String) -> Node:
	for _i in self.get_children():
		if (_i.ItemName == itemName):
			return _i
	return null

func _itemButtonPressed(itemName):
	itemButtonPressed.emit(itemName)
