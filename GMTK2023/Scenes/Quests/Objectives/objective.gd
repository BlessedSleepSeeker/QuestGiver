extends Node
class_name Objective

@export var id := 0
@export_enum("Kill", "Fetch", "Escort", "Explore", "Intimidate") var type: int = 0
@export var wantedItem = preload("res://Scenes/Items/Item.tscn")
@export var characterName = preload("res://Scenes/Characters/Character.tscn")
@export var expiration_date := 5

@export var completed: bool = false
@export var difficulty: int = 0

signal objective_finished(id)
signal objective_failed(id)
signal objective_modified(id)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func New(_id: int, _type: int, _wantedItem: Item, _characterName: Character):
	setId(_id)
	setType(_type)
	setWantedItem(_wantedItem)
	setCharacterName(_characterName)

func setId(_id):
	id = _id

func setType(_type: int):
	type = _type

func setWantedItem(_wantedItem: Item):
	wantedItem = _wantedItem

func setCharacterName(_characterName):
	characterName = _characterName

func calcDifficulty():
	return (wantedItem.getDifficulty() + characterName.getDifficulty())

func tryObjective(heroSkill: int) -> bool:
	if RngHandler.gen.randi_range(1, 100) + heroSkill > calcDifficulty():
		objective_finished.emit(id)
		return true
	objective_failed.emit(id)
	return false