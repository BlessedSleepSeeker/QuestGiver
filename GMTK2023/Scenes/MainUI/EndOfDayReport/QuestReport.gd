extends Container
class_name QuestReport

@onready var label: Label = $Report
@onready var nextButton: TextureButton = $NextButton
@onready var objectivesHolder: VBoxContainer = $ObjectivesHolder

@export var objectiveReportScene = preload("res://Scenes/MainUI/EndOfDayReport/ObjectiveReport.tscn")

var quest: Quest
var index: int = 0

signal go_next(nbr: int)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func fill(_quest: Quest, _index: int):
	quest = _quest
	generate()

func generate():
	for obj in quest.getAllObjectives():
		generateObjective(obj)

func generateObjective(obj: Objective):
	var instance = objectivesHolder.instance()
	instance.setObjective(obj)
	objectivesHolder.add_child(instance)

func flushObjectives():
	for child in objectivesHolder.get_children():
		child.queue_free()

func _on_next_button_pressed():
	pass