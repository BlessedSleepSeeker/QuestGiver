extends TextureButton
class_name ObjectiveSelectButton

@export_enum("QUEST_TYPE", "CHAR", "ITEMS", "PLAYER_ITEMS") var buttonType: String = "QUEST_TYPE"
@onready var mainLogic = get_node("/root/GameLogic")
@onready var texture = $Texture
@onready var pickWindow: SelectObjectiveWindow = $SelectObjectiveWindow

signal open_window(type: String)
signal objective_selected(type: String, obj: String)

const QuestTypePath: String = "res://Sprites/UI/Quests/Objective/%s.png"
const CharacterPath: String = "res://Sprites/UI/Characters/%s.png"
const ItemsPath: String = "res://Sprites/UI/Items/%s%s.png"
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

func updateIcon(_type: String, objName: String, _iconPath: String = ""):
	buildPath(objName, _iconPath)
	if IconPath != "":
		setTexture(load(IconPath))
	else:
		setTexture(null)

func buildPath(ItemName: String, _iconPath: String = ""):
	match (buttonType):
		"QUEST_TYPE":
			IconPath = (QuestTypePath % ItemName.to_camel_case())
		"CHAR":
			if _iconPath != "":
				IconPath = (CharacterPath % _iconPath)
			else:
				IconPath = ""
		"ITEMS", "PLAYER_ITEMS":
			IconPath = (ItemsPath % [ICON_FILENAME, ItemName]).to_camel_case()

func _on_pressed():
	loadType()
	open_window.emit(buttonType)
	pickWindow.show()

func closeWindow():
	pickWindow.hide()

func _objective_selected(type: String, objName: String, _iconPath: String):
	objective_selected.emit(type, objName)
	updateIcon(type, objName, _iconPath)
