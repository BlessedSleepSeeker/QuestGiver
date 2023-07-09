extends Node
class_name GameLogic

@onready var player: Player = $Player
@onready var inventory: Inventory = $Player/Inventory
@onready var quests: Quests = $Quests
@onready var characters: Characters = $Characters
@onready var adventurers: Adventurers = $Adventurers
@onready var items: Items = $Items
@onready var mainUi := $MainGameUI


const ITEMS_JSON_PATH = "res://Json/Items.json"

const CHAR_JSON_PATH = "res://Json/Characters.json"

var questTypes := {}
const QUEST_TYPE_JSON_PATH = "res://Json/QuestTypes.json"

var selectedItem: Node
signal sold_item(itemName: String)

enum STATE {Guild, Shop, Sleep}
var state = STATE.Shop
signal state_changed(state)

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory.item_selected.connect(_item_selected)
	get_node("MainGameUI/Margin/VBoxContainer/MovementButtons/Center/MarginContainer/VBoxContainer/MainButtonsLine/GuildButton").guild_transition.connect(_guild_transition)
	get_node("MainGameUI/Margin/VBoxContainer/MovementButtons/Center/MarginContainer/VBoxContainer/MainButtonsLine/ShopButton").shop_transition.connect(_shop_transition)
	get_node("MainGameUI/Margin/VBoxContainer/MovementButtons/Center/MarginContainer/VBoxContainer/MainButtonsLine/SleepButton/ConfirmationDialog").sleep_time.connect(_sleep_transition)
	parseItemList()
	parseCharacterList()
	parseQuestTypeList()
	generateStarterGold()
	items.generateStarterItem()
	_shop_transition()

func generateStarterGold() -> void:
	player.addGold(RngHandler.generateStarterGold())

func parseCharacterList() -> void:
	var file = FileAccess.open(CHAR_JSON_PATH, FileAccess.READ)
	var json_parsing = JSON.new()
	var error = json_parsing.parse(file.get_as_text())
	if error == OK:
		characters.setCharacterList(json_parsing.data)
		characters.loadFromCharacterList()
		#print(characters)
	else:
		print("JSON Parse Error:", json_parsing.get_error_message(), " in ", ITEMS_JSON_PATH, " at line ", json_parsing.get_error_line())

func parseItemList() -> void:
	var file = FileAccess.open(ITEMS_JSON_PATH, FileAccess.READ)
	var json_parsing = JSON.new()
	var error = json_parsing.parse(file.get_as_text())
	if error == OK:
		items.setItemList(json_parsing.data)
		items.loadFromItemList()
	else:
		print("JSON Parse Error:", json_parsing.get_error_message(), " in ", ITEMS_JSON_PATH, " at line ", json_parsing.get_error_line())

func parseQuestTypeList() -> void:
	var file = FileAccess.open(QUEST_TYPE_JSON_PATH, FileAccess.READ)
	var json_parsing = JSON.new()
	var error = json_parsing.parse(file.get_as_text())
	if error == OK:
		questTypes = json_parsing.data
		#print(questTypes)
	else:
		print("JSON Parse Error:", json_parsing.get_error_message(), " in ", ITEMS_JSON_PATH, " at line ", json_parsing.get_error_line())

func getCharacterByName(_name: String) -> Character:
	return characters.getCharacterByName(_name)

func getItemFromPlayer(_name: String) -> Item:
	return inventory.getItem(_name)

func getWantedItem(_name: String) -> Item:
	return items.getItemByName(_name)

func _item_selected(item: Item) -> void:
	selectedItem = item
	if state == STATE.Shop:
		sellItem(item)

func sellItem(item: Item):
	sold_item.emit(item.Name)
	player.addGold(item.SellValue)
	item.queue_free()

func _guild_transition() -> void:
	state = STATE.Guild
	state_changed.emit(state)

func _shop_transition() -> void:
	state = STATE.Shop
	state_changed.emit(state)

func _sleep_transition() -> void:
	state = STATE.Sleep
	state_changed.emit(state)
	Calendar.addDay()
	simulate()

func getQuestTypes() -> Dictionary:
	return questTypes

func getCharacters() -> Dictionary:
	return characters.getAllAsDictionary()

func getAllItems() -> Dictionary:
	return items.getAllItems()

func getPlayerItems() -> Dictionary:
	return player.getItemsAsDict()

func getQuests() -> Array:
	return quests.get_children()

func simulate():
	adventurers.everyoneProgressQuest()
	adventurers.everyoneLookForQuest()
