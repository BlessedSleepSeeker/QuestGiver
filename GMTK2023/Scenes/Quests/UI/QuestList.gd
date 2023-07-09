extends VBoxContainer
class_name QuestList

@export var baseQuestButton := preload("res://Scenes/Quests/UI/QuestButton.tscn")
@export var baseQuestUI := preload("res://Scenes/Quests/UI/QuestUI.tscn")
@onready var quests := get_node("/root/GameLogic/Quests")
@onready var addQuestButton := $AddQuestButton

signal open_quest_tab(questId: int)
signal updated_quest(quest: Quest)

# Called when the node enters the scene tree for the first time.
func _ready():
	addQuestButton.pressed.connect(_addQuest)
	quests.quest_added.connect(_create_questButton)

func _create_questButton(_quest: Quest):
	var instance = baseQuestButton.instantiate()
	instance.get_node("Label").text = str(_quest.id)
	instance.quest = _quest
	instance.open_quest_tab.connect(_open_quest_tab)
	add_child(instance)

func _addQuest():
	var quest = quests.addQuest()
	_open_quest_tab(quest)

func _open_quest_tab(quest: Quest):
	if quest != null:
		open_quest_tab.emit(quest)

func _updated_quest(quest: Quest):
	updated_quest.emit(quest)
