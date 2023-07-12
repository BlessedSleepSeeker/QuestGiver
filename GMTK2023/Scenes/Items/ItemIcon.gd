extends TextureButton
class_name ItemIcon

@export var item: Item = null
@onready var icon: TextureRect = $"Icon"

signal item_button_pressed(item: Item)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#buildBasePaths()
	#loadBaseTextures()

func setItem(_item: Item) -> void:
	item = _item
	item.tree_exiting.connect(reset)
	loadIconTexture()

func reset() -> void:
	item = null
	resetTexture()

func resetTexture() -> void:
	icon.set_texture(null)

func loadIconTexture() -> void:
	icon.set_texture(item.getIcon())
	tooltip_text = item.getTooltip()

func _on_pressed():
	if item:
		item_button_pressed.emit(item)
