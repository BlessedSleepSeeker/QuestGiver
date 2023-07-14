extends TextureRect
class_name QuestReport

#@onready var nextButton: TextureButton = $Center/HBoxContainer/NextButton
#@onready var prevButton: TextureButton = $Center/HBoxContainer/PrevButton
@onready var questName: Label = $MarginContainer/QuestColumn/QuestName
@onready var takenBy: Label = $MarginContainer/QuestColumn/TakenBy
@onready var objectivesHolder: VBoxContainer = $MarginContainer/QuestColumn/ObjectivesHolder

@export var objectiveReportScene = preload("res://Scenes/MainUI/EndOfDayReport/ObjectiveReport.tscn")

var quest: Quest

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func fill(_quest: Quest):
	quest = _quest
	generate()

func generate():
	generateLabel()
	for obj in quest.getAllObjectives():
		generateObjective(obj)

func generateLabel():
	questName.text = quest.getName()
	takenBy.text = "Took by %s" % quest.getAdventurer().alias


func generateObjective(obj: Objective):
	var instance = objectiveReportScene.instantiate()
	objectivesHolder.add_child(instance)
	instance.get_node("ObjectiveReport").setObjective(obj)

func flushObjectives():
	for child in objectivesHolder.get_children():
		child.queue_free()
