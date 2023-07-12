extends TextureButton
class_name ObjectiveStepButton


@export var itemOrChar: Node = null
@export_enum("QUEST_TYPE", "CHAR", "ITEMS", "PLAYER_ITEMS") var type: String = "QUEST_TYPE"
@onready var icon: TextureRect = $"Icon"

signal item_button_pressed(itemOrChar: Node)

func _ready():
	pass

func new(_type: String, _item: Node):
	itemOrChar = _item
	setType(_type)
	icon.set_texture(itemOrChar.getIcon())

func setType(_type: String):
	type = _type

func reset():
	itemOrChar = null
	resetTexture()

func resetTexture():
	icon.set_texture(null)

func _on_pressed():
	item_button_pressed.emit(itemOrChar)
