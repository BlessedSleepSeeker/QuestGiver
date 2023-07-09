extends Control

@onready var playBtn = $M/VBox/PlayButton
@onready var creditsBtn = $M/VBox/CreditsButton
@onready var quitBtn = $M/VBox/QuitButton
@export var gameScene = preload("res://Scenes/GameLogic/GameLogic.tscn")
@export var creditsScene = preload("res://Scenes/MainMenu/CreditsScene.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_quit_button_pressed():
	get_tree().quit()

func _on_credits_button_pressed():
	get_tree().change_scene_to_packed(creditsScene)

func _on_play_button_pressed():
	get_tree().change_scene_to_packed(gameScene)
