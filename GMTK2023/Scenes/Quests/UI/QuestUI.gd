extends Window
class_name QuestUI

@onready var quests = get_node("/root/GameLogic/Quests")
@onready var questsList = get_parent().get_node("QuestsList")
@onready var objectiveList = $Margin/QuestUIColumn/ObjectivesContainer/Objectives
@onready var objectiveAddButton = $Margin/QuestUIColumn/addObjectiveButton
@onready var expirationDateLabel = $Margin/QuestUIColumn/ExpirationDate
@onready var difficultyRatingLabel = $Margin/QuestUIColumn/DifficultyRating
@onready var nameLabel = $Margin/QuestUIColumn/QuestName
@onready var mainLogic = get_node("/root/GameLogic")

@export var objectiveDefaultScene = preload("res://Scenes/Quests/UI/ObjectiveUI.tscn")

var quest: Quest = null
var objectives: Array = []

signal modified(quest: Quest)

func _ready():
	hide()
	mainLogic.state_changed.connect(_state_changed)
	questsList.open_quest_tab.connect(_open)
	objectiveAddButton.pressed.connect(_add_objective)
	nameLabel.text_changed.connect(_quest_name_updated)

func _unhandled_input(event):
	if event.is_action_pressed("ui_cancel"):
		_on_close_requested()

func _open(_quest: Quest, _interactible: bool):
	setQuest(_quest)
	generate(_interactible)
	show()

func setQuest(_quest: Quest):
	quest = _quest
	if !quest.objective_added.is_connected(_objective_added):
		quest.objective_added.connect(_objective_added)
	if !quest.finished.is_connected(_quest_finished):
		quest.finished.connect(_quest_finished)
	if !quest.failed.is_connected(_quest_failed):
		quest.failed.connect(_quest_failed)
	if !quest.expired.is_connected(_quest_expired):
		quest.expired.connect(_quest_expired)

func generate(_interactible: bool) -> void:
	if quest == null:
		return
	generateName(_interactible)
	generateObjectives(_interactible)
	generateValue()
	generateDifficultyRating()

func generateName(_interactible: bool):
	title = quest.questName
	nameLabel.text = quest.questName
	nameLabel.editable = _interactible

func generateObjectives(_interactible):
	flushObjectives()
	for objct in quest.getAllObjectives():
		var instance = objectiveDefaultScene.instantiate()
		objectiveList.add_child(instance)
		instance.setObjective(objct)
		instance.setInteraction(_interactible)
		instance.modified.connect(_objective_modified)

func generateExpirationDate():
	expirationDateLabel.text = str(quest.expirationDate)

func generateDifficultyRating():
	difficultyRatingLabel.text = str(quest.difficulty)

func generateValue():
	expirationDateLabel.text = str(quest.getValue())

func _add_objective():
	quest.addObjective()

func _objective_added(_obj: Objective):
	generate(true)

func _objective_modified(_obj: Objective):
	pass

func flushObjectives() -> void:
	for _i in objectiveList.get_children():
		_i.queue_free()

func _on_close_requested():
	hide()

func _quest_name_updated(questName: String):
	quest.setName(questName)
	title = quest.questName

func _state_changed(_state: String, _playAnim: bool = true):
	await get_tree().create_timer(1).timeout
	hide()

func _quest_update(_quest: Quest):
	pass

func _quest_finished(_quest: Quest):
	_open(_quest, false)

func _quest_failed(_quest: Quest):
	_open(_quest, false)

func _quest_expired(_quest: Quest):
	_open(_quest, false)
