extends CanvasLayer

@onready var gameLogic = get_node("/root/GameLogic")
@onready var animPlayer: AnimationPlayer = $AnimationPlayer
@onready var transitionSprite: Sprite2D = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	gameLogic.state_changed.connect(_state_changed)

func _state_changed(state):
	if state <= 2:
		animPlayer.play("Transition")
		await animPlayer.animation_finished
		animPlayer.play_backwards("Transition")
		await animPlayer.animation_finished
	if state == 3:
		animPlayer.play("Transition")
		await animPlayer.animation_finished
