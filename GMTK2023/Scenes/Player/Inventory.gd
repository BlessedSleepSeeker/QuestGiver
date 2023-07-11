extends Node
class_name Inventory

var gold: int = 0

signal item_added(item: Item)
signal item_removed(item: Item)
signal item_given_reward(item: Item)

signal gold_added(amount: int)
signal gold_removed(amount: int)

@export var defaultItemScene = preload("res://Scenes/Items/Item.tscn")

signal item_selected(item: Item)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func addGold(nbr: int):
	gold += nbr
	gold_added.emit(nbr)

func removeGold(nbr: int):
	gold -= nbr
	gold_removed.emit(nbr)

func addItemByParam(itemName: String, sellValue: int, rewardValue: int, flavorText: String, stackable: bool, icon: String):
	var instance = defaultItemScene.instantiate()
	instance.ItemByParam(itemName, sellValue, rewardValue, flavorText, stackable, icon)
	add_child(instance)
	item_added.emit(instance)

func addItemByDict(itemDict: Dictionary):
	var instance = defaultItemScene.instantiate()
	instance.ItemByDict(itemDict)
	add_child(instance)
	item_added.emit(instance)

func addItem(_item: Item):
	var instance = defaultItemScene.instantiate()
	instance.ItemByCopy(_item)
	add_child(instance)
	item_added.emit(instance)

func getItemsCount() -> int:
	var count: int = 0
	for item in self.get_children():
		count += 1
	return count

func getAllItems() -> Array:
	var items := []
	for _i in self.get_children():
		items.append(_i)
	return items

func getAllItemsName() -> Array:
	var items := []
	for _i in self.get_children():
		items.append(_i.name)
	return items

func getItem(itemKey: String) -> Item:
	for _i in self.get_children():
		if (_i.name == itemKey):
			return _i
	return null

func itemSelected(_item: Item) -> void:
	#print(_item)
	if _item:
		item_selected.emit(_item)

func removeItem(_item: Item) -> void:
	for _i in get_children():
		if _i == _item:
			item_removed.emit(_item)
			_i.queue_free()


func getItemsAsDict() -> Dictionary:
	return convertItemsToDict()

func convertItemsToDict() -> Dictionary:
	var itemDict := {}
	var i: int = 0
	for _i in self.get_children():
		itemDict[i] = _i.toDict()
		i += 1
	return itemDict
