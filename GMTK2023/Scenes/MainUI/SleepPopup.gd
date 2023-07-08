extends ConfirmationDialog

signal sleep_time
# Called when the node enters the scene tree for the first time.
func _ready():
	get_cancel_button().pressed.connect(self.canceled)
	get_ok_button().pressed.connect(self.validated)

func canceled() -> void:
	pass

func validated() -> void:
	sleep_time.emit()