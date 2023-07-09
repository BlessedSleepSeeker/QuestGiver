extends Window
class_name SelectObjectiveWindow


signal selected(dict: Dictionary)

@export var objectiveButton = preload("res://Scenes/Quests/UI/ObjectiveButton.tscn")
@onready var parent = get_parent()
@export_enum("QUEST_TYPE", "CHAR", "ITEMS", "PLAYER_ITEMS") var windowType: String = "QUEST_TYPE"
var options = {}
@onready var grid = $Grid

signal objective_selected( type: String, itemName: String)

# Called when the node enters the scene tree for the first time.
func _ready():
	print("window ready")
	hide()

func setWindowType(_type: String):
	windowType = _type
	if windowType == "QUEST_TYPE":
		title = "Type"
	elif windowType == "CHAR":
		title = "Target"
	elif windowType == "ITEMS":
		title = "Desire"
	elif windowType == "PLAYER_ITEMS":
		title = "Reward"

func generate() -> void:
	flush()
	for _i in options:
		var instance = objectiveButton.instantiate()
		instance.itemButtonPressed.connect(_objective_selected)
		grid.add_child(instance)
		if windowType != "QUEST_TYPE":
			instance.new(windowType, options[_i].Name, options[_i].Name)
		else:
			instance.new(windowType, options[_i].Name, options[_i].Name)

func setOption(dict: Dictionary) -> void:
	options = dict

func _objective_selected(itemName: String) -> void:
	hide()
	objective_selected.emit(windowType, itemName)

func _on_close_requested():
	hide()

func flush():
	for _i in grid.get_children():
		_i.queue_free()
