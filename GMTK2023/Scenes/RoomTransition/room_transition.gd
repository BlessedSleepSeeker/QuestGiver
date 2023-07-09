extends CanvasLayer

@onready var gameLogic = get_node("/root/GameLogic")
@onready var animPlayer: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	gameLogic.state_changed.connect(_state_changed)

func _state_changed(state):
	print(state)
	if state <= 2:
		animPlayer.play("Transition")
		await animPlayer.animation_finished
		animPlayer.play_backwards("Transition")
	if state == 3:
		animPlayer.play("Transition")