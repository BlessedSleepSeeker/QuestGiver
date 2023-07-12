extends Container
class_name QuestReport

@onready var label = $Report
@onready var nextButton = $NextButton

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
	pass

func _on_next_button_pressed():
	pass