extends TextureButton

@export var DefaultItemName: String = "DefaultItem"
@export var ItemName: String = "DefaultItem"
@onready var icon: TextureRect = $"Icon"

signal itemButtonPressed(itemName)

var MainIconsPath: String = "res://Sprites/Items/%s/%s%s.png"
var IconPath: String
const ICON_FILENAME := "icon"
var NormalIconPath: String
const NORMAL_ICON_FILENAME := "normal"
var PressedIconPath: String
const PRESSED_ICON_FILENAME := "pressed"
var HoverIconPath: String
const HOVER_ICON_FILENAME := "hover"
var DisabledIconPath: String
const DISABLED_ICON_FILENAME := "disabled"
var FocusedIconPath: String
const FOCUSED_ICON_FILENAME := "focused"
var ClickMaskPath: String
const CLICK_MASK_PATH := "res://Sprites/Items/DefaultSizeClickMask.png"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func setName(_itemName: String):
	ItemName = _itemName
	buildPaths()
	loadTextures()

func buildPaths():
	NormalIconPath = MainIconsPath % [DefaultItemName, NORMAL_ICON_FILENAME, DefaultItemName]
	PressedIconPath = MainIconsPath % [DefaultItemName, PRESSED_ICON_FILENAME, DefaultItemName]
	HoverIconPath = MainIconsPath % [DefaultItemName, HOVER_ICON_FILENAME, DefaultItemName]
	DisabledIconPath = MainIconsPath % [DefaultItemName, DISABLED_ICON_FILENAME, DefaultItemName]
	FocusedIconPath = MainIconsPath % [DefaultItemName, FOCUSED_ICON_FILENAME, DefaultItemName]
	IconPath = (MainIconsPath % [ItemName, ICON_FILENAME, ItemName]).to_camel_case()
	ClickMaskPath = CLICK_MASK_PATH

func loadTextures():
	texture_normal = load(NormalIconPath)
	texture_pressed = load(PressedIconPath)
	texture_hover = load(HoverIconPath)
	texture_disabled = load(DisabledIconPath)
	#texture_focused = load(FocusedIconPath)
	texture_click_mask = load(ClickMaskPath)
	if ResourceLoader.exists(IconPath):
		icon.texture = load(IconPath)

func _on_pressed():
	itemButtonPressed.emit(ItemName)
