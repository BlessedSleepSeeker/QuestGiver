extends TextureButton

@export var questId := 0
@export var quest: Quest = null

signal open_quest_tab(quest: Quest)

# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(_on_click)

func _on_click() -> void:
	open_quest_tab.emit(quest)