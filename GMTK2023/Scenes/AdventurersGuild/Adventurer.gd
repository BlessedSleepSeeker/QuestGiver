extends Node
class_name Adventurer

@onready var mainLogic = get_node("/root/GameLogic")

@export var alias: String = "Tintalabus"
@export var profession: String = "Sorcerer"
@export var skill: int = 10
@export var traits: Array

@export var quest: Quest

signal quest_taken(quest: Quest)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func new(_class: String, _alias: String, _skill: int, _traits: Array):
	profession = _class
	alias = _alias
	skill = _skill
	traits = _traits

func printSelf():
	print(alias)
	print(profession)
	print(str(skill))
	print(traits)

func lookForQuest(_quest: Quest) -> void:
	if quest:
		return
	if _quest.taken or _quest.getDifficulty() == 0 or _quest.getValue() == 0:
		return
	if _quest.getDifficulty() > skill * 1.5:
		return
	if RngHandler.r(0, skill * 4) > _quest.getDifficulty():
		quest = _quest
		quest.taken = true
		quest_taken.emit(quest)
		return
	return

func progressQuest() -> void:
	if !quest:
		return
	quest.tryNextObjective(skill)

func getStatus() -> bool:
	return true if quest else false
