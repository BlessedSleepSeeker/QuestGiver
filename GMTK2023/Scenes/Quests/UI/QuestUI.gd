extends Window
class_name QuestUI

@onready var quests = get_node("/root/GameLogic/Quests")
@onready var questsList = get_parent().get_node("QuestsList")
@onready var objectiveList = $Margin/QuestUIColumn/ObjectivesContainer/Objectives
@onready var objectiveAddButton = $Margin/QuestUIColumn/ObjectivesContainer/addObjectiveButton
@onready var expirationDateLabel = $Margin/QuestUIColumn/ExpirationDate
@onready var difficultyRatingLabel = $Margin/QuestUIColumn/DifficultyRating
@onready var nameLabel = $Margin/QuestUIColumn/QuestName

@export var objectiveDefaultScene = preload("res://Scenes/Quests/UI/ObjectiveUI.tscn")

var quest: Quest = null
var objectives: Array = []

signal modified(quest: Quest)

func _ready():
	hide()
	questsList.open_quest_tab.connect(_open)
	objectiveAddButton.pressed.connect(_add_objective)

func _open(_quest: Quest):
	setQuest(_quest)
	generate()
	show()

func setQuest(_quest: Quest):
	quest = _quest
	if !quest.objective_added.is_connected(_objective_added):
		quest.objective_added.connect(_objective_added)

func generate() -> void:
	if quest == null:
		return
	generateName()
	generateObjectives()
	generateExpirationDate()
	generateDifficultyRating()

func generateName():
	title = quest.questName

func generateObjectives():
	flushObjectives()
	for objct in quest.getAllObjectives():
		var instance = objectiveDefaultScene.instantiate()
		objectiveList.add_child(instance)
		instance.setObjective(objct)
		instance.modified.connect(_objective_modified)

func generateExpirationDate():
	expirationDateLabel.text = str(quest.expirationDate)

func generateDifficultyRating():
	difficultyRatingLabel.text = str(quest.difficulty)

func _add_objective():
	quest.addObjective()

func _objective_added(_obj: Objective):
	generate()

func _objective_modified(_obj: Objective):
	pass

func flushObjectives() -> void:
	for _i in objectiveList.get_children():
		_i.queue_free()

func _on_close_requested():
	hide()
