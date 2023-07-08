extends Node
class_name GameLogic

@onready var player: Player = $Player
@onready var inventory: Inventory = $Player/Inventory
@onready var mainUi := $MainGameUI

var items := {}
const ITEMS_JSON_PATH = "res://Json/Items.json"

var characters := {}
const CHAR_JSON_PATH = "res://Json/Characters.json"

var selectedItem: Node

enum STATE {Guild, Shop, Sleep}
var state = STATE.Shop
signal state_changed

@onready var rng: RandomNumberGenerator = RandomNumberGenerator.new()
const STARTER_GOLD_MIN = 20
const STARTER_GOLD_MAX = 40

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory.item_selected.connect(_item_selected)
	get_node("MainGameUI/Margin/VBoxContainer/MovementButtons/Center/MarginContainer/VBoxContainer/MainButtonsLine/GuildButton").guild_transition.connect(_guild_transition)
	get_node("MainGameUI/Margin/VBoxContainer/MovementButtons/Center/MarginContainer/VBoxContainer/MainButtonsLine/ShopButton").shop_transition.connect(_shop_transition)
	get_node("MainGameUI/Margin/VBoxContainer/MovementButtons/Center/MarginContainer/VBoxContainer/MainButtonsLine/SleepButton/ConfirmationDialog").sleep_time.connect(_sleep_transition)
	generateSeed()
	parseItemList()
	parseCharacterList()
	generateStarterGold()
	generateStarterItem()
	_shop_transition()

func generateSeed() -> void:
	rng.randomize()

func generateStarterGold() -> void:
	player.addGold(rng.randi_range(STARTER_GOLD_MIN, STARTER_GOLD_MAX))

func generateStarterItem() -> void:
	for item in items:
		if rng.randi_range(0, 100) > getItemByKey(item)["SellValue"]:
			addItemToPlayer(item)

func parseCharacterList() -> void:
	var file = FileAccess.open(CHAR_JSON_PATH, FileAccess.READ)
	var json_parsing = JSON.new()
	var error = json_parsing.parse(file.get_as_text())
	if error == OK:
		characters = json_parsing.data
		#print(characters)
	else:
		print("JSON Parse Error:", json_parsing.get_error_message(), " in ", ITEMS_JSON_PATH, " at line ", json_parsing.get_error_line())

func parseItemList() -> void:
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

func _item_selected(item: Node) -> void:
	selectedItem = item

func _guild_transition() -> void:
	state = STATE.Guild
	state_changed.emit()

func _shop_transition() -> void:
	state = STATE.Shop
	state_changed.emit()

func _sleep_transition() -> void:
	state = STATE.Sleep
	state_changed.emit()
	Calendar.addDay()
