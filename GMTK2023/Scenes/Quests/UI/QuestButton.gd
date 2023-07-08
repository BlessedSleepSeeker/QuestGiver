extends TextureButton

@export var questId := 0

signal open_quest_tab(questId: int)

# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(_on_click)

func _on_click() -> void:
	open_quest_tab.emit(questId)