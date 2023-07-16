extends Node
class_name Landmark

@export_group("Mechanics")
@export var landmarkName: String = ""
@export var flavorText: String = "DefaultFlavorText"
@export var allowedQuestType: Array = []
@export var difficulty: int = 0

@export_group("Textures")
@export var icon: Texture2D
@export var iconPath: String = ""
@export var defaultIconPath: String = "res://Sprites/UI/Items/default.png"
@export var landmarkIconName: String = ""
@export var landmarksIconPath: String = "res://Sprites/UI/Landmarks/%s.png"

func _ready():
	if landmarkName != "":
		buildIconPath()
		loadIcon()

func new(_charName: String, _flavorText: String, _allowedQuestType: Array, _difficulty: int, _landmarkIconName: String):
	setName(_charName)
	setFlavorText(_flavorText)
	setAllowedQuestType(_allowedQuestType)
	setDifficulty(_difficulty)
	setIconName(_landmarkIconName)
	buildIconPath()
	loadIcon()

func setName(_charName: String):
	landmarkName = _charName

func setDifficulty(_difficulty):
	difficulty = _difficulty

func setFlavorText(_ft: String):
	flavorText = _ft

func setAllowedQuestType(_aqt: Array):
	allowedQuestType = _aqt

func setIconName(_in: String):
	landmarkIconName = _in

func buildIconPath():
	iconPath = (landmarksIconPath % landmarkIconName)

func loadIcon():
	if ResourceLoader.exists(iconPath):
		icon = load(iconPath)
	else:
		icon = load(defaultIconPath)

func getDifficulty():
	return difficulty

func getIcon() -> Texture2D:
	return icon

func getTooltip() -> String:
	return landmarkName

func scout():
	pass

func clean():
	pass

func loot():
	pass