extends Node
class_name Objective

var typeString = {0: "Kill", 1: "Fetch", 2: "Escort", 3: "Explore", 4: "Intimidate"}

@export var id := 0
@export_enum("Kill", "Fetch", "Escort", "Explore", "Intimidate") var type: int = 0
@export var wantedItemDefaultScene = preload("res://Scenes/Items/Item.tscn")
@export var characterDefaultScene = preload("res://Scenes/Characters/Character.tscn")
@export var expirationDate := 5
var wantedItem: Item
var character: Character

@export var completed: bool = false
@export var difficulty: int = 0

signal objective_finished(id)
signal objective_failed(id)
signal objective_modified(id)

# Called when the node enters the scene tree for the first time.
func _ready():
	wantedItem = wantedItemDefaultScene.instantiate()
	character = characterDefaultScene.instantiate()

func New(_id: int, _type: int, _wantedItem: Item, _character: Character):
	setId(_id)
	setType(_type)
	setWantedItem(_wantedItem)
	setCharacterName(_character)

func setId(_id):
	id = _id

func setType(_type: int):
	type = _type

func setWantedItem(_wantedItem: Item):
	wantedItem = _wantedItem

func setCharacterName(_character):
	character = _character

func calcDifficulty():
	return (wantedItem.getDifficulty() + character.getDifficulty())

func getPrompt() -> String:
	return "%s %s for %s" % [typeString[type], character.characterName, wantedItem.Name]

func tryObjective(heroSkill: int) -> bool:
	if RngHandler.gen.randi_range(1, 100) + heroSkill > calcDifficulty():
		objective_finished.emit(id)
		return true
	objective_failed.emit(id)
	return false
