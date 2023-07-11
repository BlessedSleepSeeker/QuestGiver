extends Node
class_name Item

@export var itemName: String = "DefaultItem"
@export var flavorText: String = "Ayo, i'm an easter egg !"
@export var sellValue: int = 0
@export var rewardValue: int = 0
@export var stackable: bool = true
@export var amount: int = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#printSelf()

func ItemByParam(_itemName: String, _sellValue: int, _rewardValue: int, _flavorText: String, _stackable: bool, _amount: int) -> void:
	itemName = _itemName
	flavorText = _flavorText
	sellValue = _sellValue
	rewardValue = _rewardValue
	stackable = _stackable
	amount = _amount

func ItemByDict(itemDict: Dictionary) -> void:
	itemName = itemDict["Name"]
	flavorText = itemDict["FlavorText"]
	sellValue = itemDict["SellValue"]
	rewardValue = itemDict["RewardValue"]
	stackable = itemDict["Stackable"]
	amount = itemDict["Amount"]

func ItemByCopy(_item: Item) -> void:
	itemName = _item.itemName
	flavorText = _item.flavorText
	sellValue = _item.sellValue
	rewardValue = _item.rewardValue
	stackable = _item.stackable
	amount = _item.amount

func getDifficulty():
	return sellValue

func getValue():
	return rewardValue

func printSelf():
	print(itemName)
	print(str(sellValue))
	print(str(rewardValue))
	print(flavorText)
	print(stackable)

func toDict() -> Dictionary:
	return {"Name": name,
			"FlavorText": flavorText,
			"SellValue": sellValue,
			"RewardValue": rewardValue,
			"Stackable": stackable,
			"Amount": amount}