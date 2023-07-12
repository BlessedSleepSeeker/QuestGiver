extends TextureButton
class_name ObjectiveStepButton


@export var itemOrChar: Node = null
@export_enum("QUEST_TYPE", "CHAR", "ITEMS", "PLAYER_ITEMS") var type: String = "QUEST_TYPE"
@onready var icon: TextureRect = $"Icon"

signal item_button_pressed(itemOrChar: Node)

func _ready():
	pass

func new(_type: String, _item: Node) -> void:
	itemOrChar = _item
	setType(_type)
	icon.set_texture(itemOrChar.getIcon())
	icon.tooltip_text = itemOrChar.getTooltip()

func setType(_type: String) -> void:
	type = _type

func reset() -> void:
	itemOrChar = null
	resetTexture()
	resetTooltip()

func resetTexture() -> void:
	icon.set_texture(null)

func resetTooltip() -> void:
	icon.tooltip_text = ""

func _on_pressed() -> void:
	item_button_pressed.emit(itemOrChar)
