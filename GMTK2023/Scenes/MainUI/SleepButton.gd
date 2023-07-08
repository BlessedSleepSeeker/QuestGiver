extends TextureButton

@onready var ConfirmationPopup = $"ConfirmationDialog"

# Called when the node enters the scene tree for the first time.
func _ready():
	ConfirmationPopup.hide()

func _on_pressed():
	ConfirmationPopup.show()