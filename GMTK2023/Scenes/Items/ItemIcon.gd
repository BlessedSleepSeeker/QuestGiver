extends TextureButton
class_name ItemIcon

@export var defaultItemName: String = "DefaultItem"
@export var item: Item = null
@onready var icon: TextureRect = $"Icon"

signal item_button_pressed(item: Item)

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
	buildBasePaths()
	loadBaseTextures()

func setItem(_item: Item) -> void:
	item = _item
	item.tree_exiting.connect(reset)
	buildIconPath()
	loadIconTexture()

func buildBasePaths() -> void:
	NormalButtonPath = DefaultButtonPath % [NORMAL_BUTTON_FILENAME, defaultItemName]
	PressedButtonPath = DefaultButtonPath % [PRESSED_BUTTON_FILENAME, defaultItemName]
	HoverButtonPath = DefaultButtonPath % [HOVER_BUTTON_FILENAME, defaultItemName]
	DisabledButtonPath = DefaultButtonPath % [DISABLED_BUTTON_FILENAME, defaultItemName]
	#FocusedButtonPath = DefaultButtonPath % [FOCUSED_BUTTON_FILENAME, defaultItemName]
	ClickMaskPath = CLICK_MASK_PATH

func buildIconPath() -> void:
	if item:
		IconPath = (IconsPath % [ICON_FILENAME, item.itemName]).to_camel_case()

func reset() -> void:
	item = null
	buildIconPath()
	resetTexture()

func resetTexture() -> void:
	icon.set_texture(null)

func loadIconTexture() -> void:
	if ResourceLoader.exists(IconPath):
		icon.set_texture(load(IconPath))

func loadBaseTextures() -> void:
	texture_normal = load(NormalButtonPath)
	texture_pressed = load(PressedButtonPath)
	texture_hover = load(HoverButtonPath)
	texture_disabled = load(DisabledButtonPath)
	texture_click_mask = load(ClickMaskPath)

func _on_pressed():
	if item:
		item_button_pressed.emit(item)
