extends Node
class_name Items

@export var items := {}
@export var defaultItem = preload("res://Scenes/Items/Item.tscn")
@onready var player = get_node("/root/GameLogic/Player")
@onready var playerInventory = get_node("/root/GameLogic/Player/Inventory")

func setItemList(dict: Dictionary):
	items = dict

func loadFromItemList():
	for _i in items:
		var instance = defaultItem.instantiate()
		instance.ItemByDict(items[_i])
		add_child(instance)
		#instance.printSelf()

func generateStarterItem() -> void:
	for item in items:
		if RngHandler.gen.randi_range(0, 100) > getItemByKey(item)["SellValue"]:
			addItemToPlayer(item)

func getItemByKey(key: String):
	if items and items.has(key):
		return items[key].duplicate(true)

func addItemToPlayer(itemKey: String) -> void:
	playerInventory.addItemByDict(getItemByKey(itemKey))

func getAllItemsAsArray() -> Array:
	var _items := []
	for _i in self.get_children():
		_items.append(_i)
	return _items

func getAllItems() -> Dictionary:
	return items

func getItemByName(_name: String) -> Item:
	for _i in self.get_children():
		if _i.Name == _name:
			return _i
	return null
