extends TextureButton

@export var questId := 0
@export var quest: Quest = null
@onready var lbl = $Label

signal open_quest_tab(quest: Quest)

# Called when the node enters the scene tree for the first time.
func _ready():
	pressed.connect(_on_click)

func _on_click() -> void:
	open_quest_tab.emit(quest)

func setQuest(_quest: Quest):
	quest = _quest
	quest.updated.connect(_update)

func _update():
	lbl.text = quest.questName