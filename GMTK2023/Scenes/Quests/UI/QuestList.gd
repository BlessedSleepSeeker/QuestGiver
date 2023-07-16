extends VBoxContainer
class_name QuestList

@export var baseQuestButton := preload("res://Scenes/Quests/UI/QuestButton.tscn")
@export var baseQuestUI := preload("res://Scenes/Quests/UI/QuestUI.tscn")
@onready var quests: Quests = get_node("/root/GameLogic/Quests")
@onready var addQuestButton := $C/DiscoverLandmarkButton
@onready var mainLogic = get_node("/root/GameLogic")

signal open_quest_tab(quest: Quest, _interactible: bool)
signal updated_quest(quest: Quest)

# Called when the node enters the scene tree for the first time.
func _ready():
	mainLogic.state_changed.connect(_state_changed)
	addQuestButton.pressed.connect(_addQuest)
	quests.quest_added.connect(create_questButton)

func create_questButton(_quest: Quest):
	var instance = baseQuestButton.instantiate()
	add_child(instance)
	instance.setQuest(_quest)
	instance.open_quest_tab.connect(_open_quest_tab)

func _addQuest():
	var quest = quests.addQuest()
	_open_quest_tab(quest)

func _open_quest_tab(quest: Quest):
	if quest != null:
		open_quest_tab.emit(quest, true)

func _updated_quest(quest: Quest):
	updated_quest.emit(quest)

func _state_changed(_state: String, _playAnim: bool = true):
	await get_tree().create_timer(1).timeout
	if _state != "Guild":
		flushQuestButtons()
		hide()
	else:
		loadQuestButtons()
		show()

func loadQuestButtons() -> void:
	for quest in quests.getAll():
		create_questButton(quest)

func flushQuestButtons() -> void:
	for questButton in self.get_children():
		if questButton is QuestButton:
			questButton.queue_free()
