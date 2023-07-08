extends TextureButton

@export var ItemName: String = "DefaultItem"

signal itemButtonPressed(itemName)

var MainIconsPath: String = "res://Sprites/Items/%s/%s%s.png"
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
	NormalIconPath = MainIconsPath % [ItemName, NORMAL_ICON_FILENAME, ItemName]
	PressedIconPath = MainIconsPath % [ItemName, PRESSED_ICON_FILENAME, ItemName]
	HoverIconPath = MainIconsPath % [ItemName, HOVER_ICON_FILENAME, ItemName]
	DisabledIconPath = MainIconsPath % [ItemName, DISABLED_ICON_FILENAME, ItemName]
	FocusedIconPath = MainIconsPath % [ItemName, FOCUSED_ICON_FILENAME, ItemName]
	ClickMaskPath = CLICK_MASK_PATH

func loadTextures():
	texture_normal = load(NormalIconPath)
	texture_pressed = load(PressedIconPath)
	texture_hover = load(HoverIconPath)
	texture_disabled = load(DisabledIconPath)
	#texture_focused = load(FocusedIconPath)
	texture_click_mask = load(ClickMaskPath)

func _on_pressed():
	itemButtonPressed.emit(ItemName)
