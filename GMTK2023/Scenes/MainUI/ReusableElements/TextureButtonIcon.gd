extends TextureButton
class_name TextureButtonIcon

@export var iconTexture: Texture2D:
	get:
		return iconTexture
	set(value):
		iconTexture = value

@onready var icon: TextureRect = $Icon

# Called when the node enters the scene tree for the first time.
func _ready():
	loadIcon()

func loadIcon():
	icon.texture = iconTexture
