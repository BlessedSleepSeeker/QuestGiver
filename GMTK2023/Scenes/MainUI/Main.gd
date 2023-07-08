extends Control

@onready var sleepButton := $"Margin/VBoxContainer/MovementButtons/Center/MarginContainer/MainButtonsLine/SleepButton"
@onready var shopButton := $"Margin/VBoxContainer/MovementButtons/Center/MarginContainer/MainButtonsLine/ShopButton"
@onready var guildButton := $"Margin/VBoxContainer/MovementButtons/Center/MarginContainer/MainButtonsLine/GuildButton"

# Called when the node enters the scene tree for the first time.
func _ready():
	sleepButton.ConfirmationPopup.sleep_time.connect(self.sleep)
	shopButton.shop_transition.connect(self.goToShop)
	guildButton.guild_transition.connect(self.goToGuild)


func sleep():
	print("sleep time")

func goToShop():
	print("shop time")

func goToGuild():
	print("guild time")
