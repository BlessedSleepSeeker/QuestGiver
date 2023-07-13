extends Node
class_name Character

@export_group("Mechanics")
@export var characterName: String = ""
@export var flavorText: String = "DefaultFlavorText"
@export var allowedQuestType: Array = []
@export var difficulty: int = 0

@export_group("Textures")
@export var icon: Texture2D
@export var iconPath: String = ""
@export var characterIconName: String = ""
@export var charactersIconPath: String = "res://Sprites/UI/Characters/%s.png"

func _ready():
	if characterName != "":
		buildIconPath()
		loadIcon()

func new(_charName: String, _flavorText: String, _allowedQuestType: Array, _difficulty: int, _characterIconName: String):
	setName(_charName)
	setFlavorText(_flavorText)
	setAllowedQuestType(_allowedQuestType)
	setDifficulty(_difficulty)
	setIconName(_characterIconName)
	buildIconPath()
	loadIcon()

func setName(_charName: String):
	characterName = _charName

func setDifficulty(_difficulty):
	difficulty = _difficulty

func setFlavorText(_ft: String):
	flavorText = _ft

func setAllowedQuestType(_aqt: Array):
	allowedQuestType = _aqt

func setIconName(_in: String):
	characterIconName = _in

func buildIconPath():
	iconPath = (charactersIconPath % characterIconName)

func loadIcon():
	if ResourceLoader.exists(iconPath):
		icon = load(iconPath)

func getDifficulty():
	return difficulty

func getIcon() -> Texture2D:
	return icon

func getTooltip() -> String:
	return characterName