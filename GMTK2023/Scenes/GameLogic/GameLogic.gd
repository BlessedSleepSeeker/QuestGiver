extends Node
class_name GameLogic

@onready var player: Player = $Player
@onready var inventory: Inventory = $Player/Inventory
@onready var quests: Quests = $Quests
@onready var landmarks: Landmarks = $Landmarks
@onready var adventurers: Adventurers = $Adventurers
@onready var items: Items = $Items
@onready var questTypes: QuestTypes = $QuestTypes
@onready var mainUi := $MainGameUI
@onready var inventoryUi := $MainGameUI/Margin/VBoxContainer/Center/InventoryUI

@export_enum("Wakey", "Guild", "Shop", "Tavern", "Sleep") var state = "Wakey"
signal state_changed(state: String, playAnim: bool)

# Called when the node enters the scene tree for the first time.
func _ready():
	inventory.item_selected.connect(_item_selected)
	inventoryUi.item_button_pressed.connect(_item_selected_ui)
	get_node("MainGameUI/Margin/VBoxContainer/MovementButtons/Center/MarginContainer/VBoxContainer/MainButtonsLine/GuildButton").guild_transition.connect(_guild_transition)
	get_node("MainGameUI/Margin/VBoxContainer/MovementButtons/Center/MarginContainer/VBoxContainer/MainButtonsLine/ShopButton").shop_transition.connect(_shop_transition)
	get_node("MainGameUI/Margin/VBoxContainer/MovementButtons/Center/MarginContainer/VBoxContainer/MainButtonsLine/TavernButton").tavern_transition.connect(_tavern_transition)
	get_node("MainGameUI/Margin/VBoxContainer/MovementButtons/Center/MarginContainer/VBoxContainer/MainButtonsLine/SleepButton/ConfirmationDialog").sleep_time.connect(_sleep_transition)
	get_node("MainGameUI/Margin/VBoxContainer/Center/EndOfDayReport").report_finished.connect(_report_finished)

	landmarks.parseListFromJSON()
	questTypes.parseListFromJSON()
	items.parseListFromJSON()
	generateGameState()

	_wakey_transition()

func generateGameState() -> void:
	player.generateStarterGold()
	items.generateStarterItem()

func getLandmarkByName(_name: String) -> Landmark:
	return landmarks.getLandmarkByName(_name)

func getItemFromPlayer(_name: String) -> Item:
	return inventory.getItem(_name)

func getItem(_name: String) -> Item:
	return items.getItemByName(_name)

func _item_selected_ui(_item: Item):
	inventory.itemSelected(_item)

func _item_selected(item: Item) -> void:
	if state == "Shop":
		sellItem(item)

func sellItem(item: Item):
	player.addGold(item.sellValue)
	inventory.removeItem(item)

func _wakey_transition() -> void:
	state = "Wakey"
	state_changed.emit(state)
	#await get_tree().create_timer(0.5).timeout
	_shop_transition(false)

func _guild_transition() -> void:
	state = "Guild"
	state_changed.emit(state)

func _shop_transition(playAnim: bool = true) -> void:
	state = "Shop"
	state_changed.emit(state, playAnim)

func _tavern_transition() -> void:
	state = "Tavern"
	state_changed.emit(state)

func _sleep_transition() -> void:
	state = "Sleep"
	simulate()
	state_changed.emit(state)
	Calendar.addDay()

func _report_finished():
	_shop_transition()

func getQuestTypes() -> Array:
	return questTypes.getAll()

func getLandmarks() -> Array:
	return landmarks.getAll()

func getAllItems() -> Array:
	return items.getAllItems()

func getPlayerItems() -> Array:
	return player.getItems()

func getQuests() -> Array:
	return quests.get_children()

func simulate():
	adventurers.everyoneProgressQuest()
	adventurers.everyoneLookForQuest()
