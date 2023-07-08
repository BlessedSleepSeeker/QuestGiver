extends CanvasLayer

@onready var GameLogic = get_node("/root/GameLogic")
@onready var animPlayer: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	GameLogic.state_changed.connect(_state_changed)

func _state_changed():
	animPlayer.play("Transition")
	await animPlayer.animation_finished
	animPlayer.play("Transition")