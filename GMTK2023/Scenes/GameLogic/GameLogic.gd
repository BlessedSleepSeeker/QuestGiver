extends Node

@onready var player: Player = $Player
@onready var inventory: Inventory = $Player/Inventory
@onready var mainUi := $MainGameUI

const ITEMS_JSON_PATH = "res://Json/Items.json"

var items := {}

# Called when the node enters the scene tree for the first time.
func _ready():
	parseObjectList()
	addItemToPlayer("Diamond")
	addItemToPlayer("Apple")
	print(getItemFromPlayer("Diamond"))
	print(inventory.getAllItemsName())

func parseObjectList() -> void:
	var file = FileAccess.open(ITEMS_JSON_PATH, FileAccess.READ)
	var json_parsing = JSON.new()
	var error = json_parsing.parse(file.get_as_text())
	if error == OK:
		items = json_parsing.data
		#print(items)
	else:
		print("JSON Parse Error:", json_parsing.get_error_message(), " in ", ITEMS_JSON_PATH, " at line ", json_parsing.get_error_line())

func getItemByKey(key: String):
	if items and items.has(key):
		return items[key].duplicate(true)

func addItemToPlayer(itemKey: String) -> void:
	inventory.addItemByDict(getItemByKey(itemKey))

func getItemFromPlayer(itemKey: String) -> Node:
	return inventory.getItem(itemKey)
