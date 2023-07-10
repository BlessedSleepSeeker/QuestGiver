extends TextureButton
class_name ItemIcon

@export var DefaultItemName: String = "DefaultItem"
@export var ItemName: String = "DefaultItem"
@onready var icon: TextureRect = $"Icon"

signal itemButtonPressed(itemName)

var IconsPath: String = "res://Sprites/UI/Items/%s%s.png"
var IconPath: String
const ICON_FILENAME := "icon"

var DefaultButtonPath: String = "res://Sprites/UI/DefaultButton/%s%s.png"
var NormalButtonPath: String
const NORMAL_BUTTON_FILENAME := "normal"
var PressedButtonPath: String
const PRESSED_BUTTON_FILENAME := "pressed"
var HoverButtonPath: String
const HOVER_BUTTON_FILENAME := "hover"
var DisabledButtonPath: String
const DISABLED_BUTTON_FILENAME := "disabled"
var FocusedButtonPath: String
const FOCUSED_BUTTON_FILENAME := "focused"
var ClickMaskPath: String
const CLICK_MASK_PATH := "res://Sprites/UI/ClickMasks/DefaultSizeClickMask.png"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func setName(_itemName: String):
	ItemName = _itemName
	buildPaths()
	loadBaseTextures()
	loadIconTexture()

func buildPaths():
	NormalButtonPath = DefaultButtonPath % [NORMAL_BUTTON_FILENAME, DefaultItemName]
	PressedButtonPath = DefaultButtonPath % [PRESSED_BUTTON_FILENAME, DefaultItemName]
	HoverButtonPath = DefaultButtonPath % [HOVER_BUTTON_FILENAME, DefaultItemName]
	DisabledButtonPath = DefaultButtonPath % [DISABLED_BUTTON_FILENAME, DefaultItemName]
	#FocusedButtonPath = DefaultButtonPath % [FOCUSED_BUTTON_FILENAME, DefaultItemName]
	IconPath = (IconsPath % [ICON_FILENAME, ItemName]).to_camel_case()
	ClickMaskPath = CLICK_MASK_PATH

func reset():
	ItemName = DefaultItemName
	buildPaths()
	resetTexture()

func resetTexture():
	icon.set_texture(null)

func loadIconTexture():
	if ResourceLoader.exists(IconPath):
		icon.set_texture(load(IconPath))

func loadBaseTextures():
	texture_normal = load(NormalButtonPath)
	texture_pressed = load(PressedButtonPath)
	texture_hover = load(HoverButtonPath)
	texture_disabled = load(DisabledButtonPath)
	texture_click_mask = load(ClickMaskPath)

func _on_pressed():
	itemButtonPressed.emit(ItemName)
