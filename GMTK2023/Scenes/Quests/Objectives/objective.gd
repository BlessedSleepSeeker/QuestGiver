extends Node
class_name Objective

@export var id := 0
@export var expirationDate := 5
@export_enum("Kill", "Fetch", "Escort", "Explore", "Intimidate", "Seduce") var type: String = "Kill"

@onready var mainLogic = get_node("/root/GameLogic")
var character: Character
var wantedItem: Item
var reward: Item

@export var completed: bool = false
@export var failed: bool = false
@export var attempted: bool = false
@export var difficulty: int = 0

signal updated
signal objective_finished(id)
signal objective_failed(id)
signal objective_modified(id)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func new(_id: int, _type: String, _wantedItem: Item, _character: Character):
	setId(_id)
	setType(_type)
	setWantedItem(_wantedItem)
	setCharacter(_character)

func setId(_id):
	id = _id
	updated.emit()

func setType(_type: String):
	type = _type
	updated.emit()

func setWantedItem(_wantedItem: Item):
	wantedItem = _wantedItem
	updated.emit()

func setCharacter(_character: Character):
	character = _character
	updated.emit()

func setReward(_reward: Item):
	reward = _reward
	updated.emit()

func getValue() -> int:
	if reward:
		return reward.getValue()
	return 0

func calcDifficulty():
	var a = 0
	var b = 0
	if wantedItem:
		a = wantedItem.getDifficulty()
	if character:
		b = character.getDifficulty()
	return (a + b)

func tryObjective(heroSkill: int) -> bool:
	if RngHandler.gen.randi_range(1, 100) + heroSkill > calcDifficulty():
		completed = true
		objective_finished.emit(id)
		return true
	failed = true
	objective_failed.emit(id)
	return false

func setCharacterByName(_name: String,):
	character = mainLogic.getCharacterByName(_name)
	updated.emit()

# false is item
# true is reward
func setItemByName(_name: String, isReward: bool):
	if isReward:
		reward = mainLogic.getItemFromPlayer(_name)
	else:
		wantedItem = mainLogic.getWantedItem(_name)
	updated.emit()

func getStatus():
	if completed:
		return 3
	elif failed:
		return 2
	elif attempted:
		return 1
	return 0
