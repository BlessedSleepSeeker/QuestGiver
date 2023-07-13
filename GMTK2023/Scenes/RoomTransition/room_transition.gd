extends CanvasLayer

@onready var gameLogic = get_node("/root/GameLogic")
@onready var animPlayer: AnimationPlayer = $AnimationPlayer
@onready var transitionSprite: Sprite2D = $Sprite2D

signal animation_played(_state: String)

# Called when the node enters the scene tree for the first time.
func _ready():
	gameLogic.state_changed.connect(_state_changed)

func _state_changed(state: String, playAnim: bool = true):
	if not playAnim:
		return
	match state:
		"Wakey": playWakey()
		"Shop", "Guild", "Tavern": playTransition()
		"Sleep": playSleep()
	animation_played.emit(state)

func playWakey() -> void:
	transitionSprite.hide()
	animPlayer.play_backwards("SleepFade")
	#await animPlayer.animation_finished

func playTransition() -> void:
	transitionSprite.show()
	animPlayer.play("Transition")
	await animPlayer.animation_finished
	animPlayer.play_backwards("Transition")
	await animPlayer.animation_finished
	transitionSprite.hide()

func playSleep() -> void:
	transitionSprite.hide()
	animPlayer.play("SleepFade")
	await animPlayer.animation_finished
	animPlayer.play_backwards("SleepFade")