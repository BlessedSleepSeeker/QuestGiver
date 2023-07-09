extends TextureButton
class_name ObjectiveSelectButton

@export_enum("QUEST_TYPE", "CHAR", "ITEMS", "PLAYER_ITEMS") var buttonType: String = "QUEST_TYPE"
@onready var mainLogic = get_node("/root/GameLogic")
@onready var texture = $Texture
@onready var pickWindow: SelectObjectiveWindow = $SelectObjectiveWindow

signal open_window(type: String)
signal objective_selected(type: String, obj: String)

const QuestTypePath: String = "res://Sprites/UI/Quest/Objective/%s.png"
const CharacterPath: String = "res://Sprites/UI/Character/%s.png"
const ItemsPath: String = "res://Sprites/Items/%s/%s%s.png"
var IconPath: String
const ICON_FILENAME := "icon"

# Called when the node enters the scene tree for the first time.
func _ready():
	loadType()
	pickWindow.objective_selected.connect(_objective_selected)

func loadType():
	if buttonType == "QUEST_TYPE":
		loadQuestType()
	elif buttonType == "CHAR":
		loadCharacters()
	elif buttonType == "ITEMS":
		loadItems()
	elif buttonType == "PLAYER_ITEMS":
		loadPlayerItems()
	pickWindow.setWindowType(buttonType)
	pickWindow.generate()

func loadQuestType() -> void:
	pickWindow.setOption(mainLogic.getQuestTypes())

func loadCharacters() -> void:
	pickWindow.setOption(mainLogic.getCharacters())

func loadItems() -> void:
	pickWindow.setOption(mainLogic.getAllItems())

func loadPlayerItems() -> void:
	pickWindow.setOption(mainLogic.getPlayerItems())

func setTexture(_texture: Texture2D):
	texture.texture = _texture

func updateIcon(_type: String, objName: String):
	buildPath(objName)
	setTexture(load(IconPath))

func buildPath(ItemName: String):
	match (buttonType):
		"QUEST_TYPE":
			IconPath = (QuestTypePath % ItemName.to_camel_case())
		"CHAR":
			IconPath = (CharacterPath % ItemName.to_camel_case())
		"ITEMS", "PLAYER_ITEMS":
			IconPath = (ItemsPath % [ItemName, ICON_FILENAME, ItemName]).to_camel_case()

func _on_pressed():
	loadType()
	open_window.emit(buttonType)
	pickWindow.show()

func closeWindow():
	pickWindow.hide()

func _objective_selected(type: String, objName: String):
	objective_selected.emit(type, objName)
	updateIcon(type, objName)
