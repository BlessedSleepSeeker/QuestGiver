extends Control

@onready var movementButtons := $"Margin/VBoxContainer/MovementButtons/"
@onready var transitionHandler := get_node("/root/GameLogic/RoomTransition")
@onready var fader := $Fader

# Called when the node enters the scene tree for the first time.
func _ready():
	#sleepButton.ConfirmationPopup.sleep_time.connect(self.sleep)
	#shopButton.shop_transition.connect(self.goToShop)
	#guildButton.guild_transition.connect(self.goToGuild)
	#tavernButton.tavern_transition.connect(self.goToTavern)
	transitionHandler.animation_played.connect(_play_anim)
	
func _play_anim(anim: String):
	match anim:
		"Wakey": wakey()
		"Shop", "Guild", "Tavern": transition()
		"Sleep": sleep()

func wakey():
	movementButtons.show()
	#$Margin.hide()
	#await get_tree().create_timer(1.4).timeout
	#fader.play_backwards("FadeOut")
	#$Margin.show()

func sleep():
	fader.play("FadeOut")
	await fader.animation_finished
	movementButtons.hide()
	fader.play_backwards("FadeOut")
	#await fader.animation_finished

func transition():
	fader.play("FadeOut")
	await fader.animation_finished
	movementButtons.show()
	fader.play_backwards("FadeOut")
	#await fader.animation_finished

func goToGuild():
	fader.play("FadeOut")
	await fader.animation_finished
	fader.play_backwards("FadeOut")
	await fader.animation_finished

func goToTavern():
	fader.play("FadeOut")
	await fader.animation_finished
	fader.play_backwards("FadeOut")
	await fader.animation_finished
