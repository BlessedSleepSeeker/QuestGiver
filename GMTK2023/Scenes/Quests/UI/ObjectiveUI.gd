extends Container


@export var objective: Objective
@onready var label := $Label

signal modified(obj: Objective)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func generate() -> void:
	label.text = objective.getPrompt()
