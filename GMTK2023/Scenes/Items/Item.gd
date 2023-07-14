extends Node
class_name Item

@export_group("Mechanics")
@export var itemName: String = "DefaultItem"
@export var flavorText: String = "Ayo, i'm an easter egg !"
@export var sellValue: int = 0
@export var rewardValue: int = 0
@export var stackable: bool = true
@export var amount: int = 1

@export_group("Textures")
@export var icon: Texture2D = null
@export var iconPath: String = ""
@export var defaultIconPath: String = "res://Sprites/UI/Items/default.png"
@export var itemsIconPath: String = "res://Sprites/UI/Items/%s.png"

# Called when the node enters the scene tree for the first time.
func _ready():
	if itemName != "":
		buildIconPath()
		loadIcon()

func ItemByParam(_itemName: String, _sellValue: int, _rewardValue: int, _flavorText: String, _stackable: bool, _amount: int) -> void:
	itemName = _itemName
	flavorText = _flavorText
	sellValue = _sellValue
	rewardValue = _rewardValue
	stackable = _stackable
	amount = _amount
	buildIconPath()
	loadIcon()

func ItemByDict(itemDict: Dictionary) -> void:
	itemName = itemDict["Name"]
	flavorText = itemDict["FlavorText"]
	sellValue = itemDict["SellValue"]
	rewardValue = itemDict["RewardValue"]
	stackable = itemDict["Stackable"]
	amount = itemDict["Amount"]
	buildIconPath()
	loadIcon()

func ItemByCopy(_item: Item) -> void:
	itemName = _item.itemName
	flavorText = _item.flavorText
	sellValue = _item.sellValue
	rewardValue = _item.rewardValue
	stackable = _item.stackable
	amount = _item.amount
	buildIconPath()
	loadIcon()

func buildIconPath() -> void:
	iconPath = (itemsIconPath % [itemName.to_camel_case()])

func loadIcon() -> void:
	if ResourceLoader.exists(iconPath):
		icon = load(iconPath)
	else:
		icon = load(defaultIconPath)

func getIcon() -> Texture2D:
	return icon

func getDifficulty() -> int:
	return sellValue

func getValue() -> int:
	return rewardValue

func getTooltip():
	return itemName

func printSelf() -> void:
	print(itemName)
	print(str(sellValue))
	print(str(rewardValue))
	print(flavorText)
	print(stackable)
	print(iconPath)

func toDict() -> Dictionary:
	return {"Name": name,
			"FlavorText": flavorText,
			"SellValue": sellValue,
			"RewardValue": rewardValue,
			"Stackable": stackable,
			"Amount": amount}
