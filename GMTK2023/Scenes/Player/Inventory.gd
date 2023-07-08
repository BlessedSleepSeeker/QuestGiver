extends Node
class_name Inventory

var gold: int = 0

signal item_added(itemName)
signal item_sold(itemName)
signal item_reward(itemName)

signal gold_added(nbr)
signal gold_removed(nbr)

@export var defaultItemScene = preload("res://Scenes/Items/Item.tscn")
@onready var inventoryUi = get_node("/root/GameLogic/MainGameUI/Margin/VBoxContainer/MainSpaceColumns/InventoryUI")

signal item_selected(Item)

# Called when the node enters the scene tree for the first time.
func _ready():
	#addItem("DefaultItem", 0, 0, "EasterEgg !", "DefaultItem")
	inventoryUi.itemButtonPressed.connect(_itemSelected)

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

func addItemByDict(itemDict: Dictionary):
	var instance = defaultItemScene.instantiate()
	instance.ItemByDict(itemDict)
	add_child(instance)
	item_added.emit(instance.Name)

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

func getItem(itemKey: String) -> Node:
	for _i in self.get_children():
		if (_i.Name == itemKey):
			#print("found %s!" % itemKey)
			return _i
	return null

func _itemSelected(itemName):
	item_selected.emit(getItem(itemName))