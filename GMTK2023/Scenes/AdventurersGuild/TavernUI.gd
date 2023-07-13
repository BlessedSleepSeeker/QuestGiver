extends VBoxContainer

@onready var mainLogic = get_node("/root/GameLogic")
@onready var adventurers = mainLogic.get_node("Adventurers")
@export var defaultUI = preload("res://Scenes/AdventurersGuild/AdventurerPortrait.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	mainLogic.state_changed.connect(_state_changed)

func _state_changed(_state: String, _playAnim: bool = true):
	await get_tree().create_timer(1).timeout
	hide()
	flush()
	if _state == "Tavern":
		loadAdventurers()
		show()

func flush():
	for _i in get_children():
		_i.queue_free()

func loadAdventurers():
	for _i in adventurers.get_children():
		loadAdventurer(_i)

func loadAdventurer(adv: Adventurer):
	var instance = defaultUI.instantiate()
	add_child(instance)
	instance.fill(adv)
