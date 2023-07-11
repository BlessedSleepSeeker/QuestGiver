extends Node
class_name Items

@export var itemList: Dictionary = {}
@export var defaultItem = preload("res://Scenes/Items/Item.tscn")
@onready var player: Player = get_node("/root/GameLogic/Player")
@onready var playerInventory: Inventory = get_node("/root/GameLogic/Player/Inventory")

@export var MAX_STARTER_ITEM = 2

func setItemList(dict: Dictionary):
	itemList = dict

func loadFromItemList():
	for _i in itemList:
		var instance = defaultItem.instantiate()
		instance.ItemByDict(itemList[_i])
		add_child(instance)
		#instance.printSelf()

func generateStarterItem() -> void:
	var count: int = 0
	var items = self.get_children()
	items.shuffle()
	for item in items:
		if RngHandler.gen.randi_range(0, 100) > item.sellValue:
			addItemToPlayer(item)
			count += 1
		if count > MAX_STARTER_ITEM:
			return

func addItemToPlayer(item: Item) -> void:
	playerInventory.addItem(item)

func getItemByKey(key: String):
	if itemList and itemList.has(key):
		return itemList[key].duplicate(true)

func getLoadedItemsAsArray() -> Array:
	var _itemList := []
	for _i in self.get_children():
		_itemList.append(_i)
	return _itemList

func getAllItemList() -> Dictionary:
	return itemList

func getItemByName(_name: String) -> Item:
	for _i in self.get_children():
		if _i.Name == _name:
			return _i
	return null
