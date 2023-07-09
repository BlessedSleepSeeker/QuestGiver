extends TextureButton


@export var DefaultItemName: String = "DefaultItem"
@export var ItemName: String = "DefaultItem"
@export_enum("QUEST_TYPE", "CHAR", "ITEMS", "PLAYER_ITEMS") var type: String = "QUEST_TYPE"
@onready var icon: TextureRect = $"Icon"

signal itemButtonPressed(itemName: String)

const QuestTypePath: String = "res://Sprites/UI/Quest/Objective/%s.png"
const CharacterPath: String = "res://Sprites/UI/Character/%s.png"
const ItemsPath: String = "res://Sprites/Items/%s/%s%s.png"
var IconPath: String
const ICON_FILENAME := "icon"

func _ready():
	pass

func new(_type: String, _itemName: String, _flavorText: String):
	ItemName = _itemName
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
			IconPath = (CharacterPath % ItemName.to_camel_case())
			print(IconPath)
		"ITEMS", "PLAYER_ITEMS":
			IconPath = (ItemsPath % [ItemName, ICON_FILENAME, ItemName]).to_camel_case()

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
	itemButtonPressed.emit(ItemName)
