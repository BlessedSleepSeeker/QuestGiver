extends Node
class_name QuestType

@export_group("Mechanics")
@export var typeName: String = ""
@export var difficulty: int = 0
@export var reputationRequired: int = 0

@export_group("Textures")
@export var icon: Texture2D = null
@export var iconPath: String = ""
@export var defaultIconPath: String = "res://Sprites/UI/Items/default.png"
@export var typeIconPath: String = "res://Sprites/UI/Quests/Objective/%s.png"

# Called when the node enters the scene tree for the first time.
func _ready():
	if typeName != "":
		buildIconPath()
		loadIcon()

func new(_typeName: String, _difficulty: int, _reputationRequired: int) -> void:
	typeName = _typeName
	difficulty = _difficulty
	reputationRequired = _reputationRequired
	buildIconPath()
	loadIcon()

func buildIconPath() -> void:
	iconPath = typeIconPath % typeName.to_camel_case()

func loadIcon() -> void:
	if ResourceLoader.exists(iconPath):
		icon = load(iconPath)
	else:
		icon = load(defaultIconPath)

func getIcon() -> Texture2D:
	return icon

func getTooltip() -> String:
	return typeName