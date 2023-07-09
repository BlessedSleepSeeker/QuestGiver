extends GridContainer

var rows := 5
var slots := columns * rows

@export var itemButton := preload("res://Scenes/Items/ItemIcon.tscn")

@onready var inventory := get_node("/root/GameLogic/Player/Inventory")
@onready var mainLogic := get_node("/root/GameLogic")

signal itemButtonPressed(itemName)

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in slots:
		var instance = itemButton.instantiate()
		instance.setName("DefaultItem")
		instance.itemButtonPressed.connect(_itemButtonPressed)
		add_child(instance)
	inventory.item_added.connect(_item_added)
	mainLogic.sold_item.connect(_item_removed)
	mainLogic.state_changed.connect(_state_changed)

func _item_added(itemName: String):
	var inventory_spot = getItem("DefaultItem") # search for empty spot
	inventory_spot.setName(itemName)

func _item_removed(itemName: String):
	var inv_spot = getItem(itemName) #find the occupied space
	inv_spot.reset()

func getItem(itemName: String) -> ItemIcon:
	for _i in self.get_children():
		if (_i.ItemName == itemName):
			return _i
	return null

func _itemButtonPressed(itemName):
	itemButtonPressed.emit(itemName)

func _state_changed(_state: int):
	await get_tree().create_timer(1).timeout
	if _state != 1:
		hide()
	else:
		show()
