extends Control

@onready var sleepButton := $"Margin/VBoxContainer/MovementButtons/Center/MarginContainer/VBoxContainer/MainButtonsLine/SleepButton"
@onready var shopButton := $"Margin/VBoxContainer/MovementButtons/Center/MarginContainer/VBoxContainer/MainButtonsLine/ShopButton"
@onready var guildButton := $"Margin/VBoxContainer/MovementButtons/Center/MarginContainer/VBoxContainer/MainButtonsLine/GuildButton"
@onready var tavernButton := $"Margin/VBoxContainer/MovementButtons/Center/MarginContainer/VBoxContainer/MainButtonsLine/TavernButton"
@onready var fader := $Fader

# Called when the node enters the scene tree for the first time.
func _ready():
	sleepButton.ConfirmationPopup.sleep_time.connect(self.sleep)
	shopButton.shop_transition.connect(self.goToShop)
	guildButton.guild_transition.connect(self.goToGuild)
	tavernButton.tavern_transition.connect(self.goToTavern)
	$Margin.hide()
	await get_tree().create_timer(1.7).timeout
	fader.play_backwards("FadeOut")
	$Margin.show()

func sleep():
	fader.play("FadeOut")
	await fader.animation_finished
	fader.play_backwards("FadeOut")
	await fader.animation_finished

func goToShop():
	fader.play("FadeOut")
	await fader.animation_finished
	fader.play_backwards("FadeOut")
	await fader.animation_finished

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
