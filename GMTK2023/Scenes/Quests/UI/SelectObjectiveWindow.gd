extends Window
class_name SelectObjectiveWindow


signal selected(dict: Dictionary)

@export var objectiveButton = preload("res://Scenes/Quests/UI/ObjectiveButton.tscn")
@onready var parent = get_parent()
@export_enum("QUEST_TYPE", "CHAR", "ITEMS", "PLAYER_ITEMS") var windowType: String = "QUEST_TYPE"
var options := []
@onready var grid = $Grid

signal objective_selected(type: String, itemName: String, _iconPath: String)

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

func setWindowType(_type: String):
	windowType = _type
	match windowType:
		"QUEST_TYPE":title = "Type"
		"CHAR": title = "Target"
		"ITEMS": title = "Desire"
		"PLAYER_ITEMS": title = "Reward"

func generate() -> void:
	flush()
	for _i in range(options.size() - 1):
		var instance = objectiveButton.instantiate()
		instance.item_button_pressed.connect(_objective_selected)
		grid.add_child(instance)
		instance.new(windowType, options[_i])
		# if windowType != "QUEST_TYPE":
		# 	instance.new(windowType, options[_i])
		# if windowType == "CHAR":
		# 	instance.new(windowType, options[_i])
		# else:
		# 	instance.new(windowType, options[_i])

func setOption(arr: Array) -> void:
	options = arr

func _objective_selected(item: Node) -> void:
	hide()
	objective_selected.emit(windowType, item)

func _on_close_requested():
	hide()

func flush():
	for _i in grid.get_children():
		_i.queue_free()
