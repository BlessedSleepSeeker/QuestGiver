extends GridContainer

var rows := 5
var slots := columns * rows

@export var itemButton := preload("res://Scenes/Items/ItemIcon.tscn")

@onready var inventory := get_node("/root/GameLogic/Player/Inventory")
@onready var mainLogic := get_node("/root/GameLogic")

signal item_button_pressed(item: Item)

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in slots:
		var instance = itemButton.instantiate()
		instance.item_button_pressed.connect(_item_button_pressed)
		add_child(instance)
	inventory.item_added.connect(_item_added)
	inventory.item_removed.connect(_item_removed)
	mainLogic.state_changed.connect(_state_changed)

func _item_added(item: Item):
	var inventory_spot = getEmptySpot() # search for empty spot
	inventory_spot.setItem(item)

func getEmptySpot() -> ItemIcon:
	for _i in self.get_children():
		if _i.item == null:
			return _i
	return null

func _item_removed(_item: Item):
	pass
	# var itemSpot: ItemIcon
	# if item:
	# 	itemSpot = getItemSpot(item)
	# if itemSpot:
	# 	itemSpot.reset()



func getItemSpot(_item: Item) -> ItemIcon:
	for _i in self.get_children():
		if _i == _item:
			return _i
	return null

func getItemSpotByName(itemName: String) -> ItemIcon:
	for _i in self.get_children():
		if _i.item.itemName == itemName:
			return _i
	return null

func _item_button_pressed(item: Item):
	item_button_pressed.emit(item)

func _state_changed(_state: int):
	await get_tree().create_timer(1).timeout
	if _state != 1:
		hide()
	else:
		show()
