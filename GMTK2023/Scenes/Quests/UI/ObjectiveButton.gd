extends TextureButton


@export var DefaultItemName: String = "DefaultItem"
@export var ItemName: String = "DefaultItem"
@export_enum("QUEST_TYPE", "CHAR", "ITEMS", "PLAYER_ITEMS") var type: String = "QUEST_TYPE"
@onready var icon: TextureRect = $"Icon"

signal itemButtonPressed(itemName: String, _iconName: String)

const QuestTypePath: String = "res://Sprites/UI/Quests/Objective/%s.png"
const CharacterPath: String = "res://Sprites/UI/Characters/%s.png"
const ItemsPath: String = "res://Sprites/UI/Items/%s%s.png"
var IconPathSmall: String
var IconPath: String
const ICON_FILENAME := "icon"

func _ready():
	pass

func new(_type: String, _itemName: String, _flavorText: String, _iconPath: String = "Default"):
	ItemName = _itemName
	IconPathSmall = _iconPath
	setType(_type)
	tooltip_text = _flavorText
	buildPath()
	loadIconTexture()

func setType(_type: String):
	type = _type

func buildPath():
	match (type):
		"QUEST_TYPE":
			IconPath = (QuestTypePath % ItemName.to_camel_case())
		"CHAR":
			IconPath = (CharacterPath % IconPathSmall)
			#print(IconPath)
		"ITEMS", "PLAYER_ITEMS":
			IconPath = (ItemsPath % [ICON_FILENAME, ItemName]).to_camel_case()

func reset():
	ItemName = DefaultItemName
	buildPath()
	resetTexture()

func resetTexture():
	icon.set_texture(null)

func loadIconTexture():
	if ResourceLoader.exists(IconPath):
		icon.set_texture(load(IconPath))

func _on_pressed():
	itemButtonPressed.emit(ItemName, IconPathSmall)
