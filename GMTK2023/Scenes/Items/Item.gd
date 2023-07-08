extends Node
class_name Item

@export var Name: String = "DefaultItem"
@export var FlavorText: String = "Ayo, i'm an easter egg !"
@export var SellValue: int = 0
@export var RewardValue: int = 0
@export var Stackable: bool = true
@export var Amount: int = 1


# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	#printSelf()

func ItemByParam(itemName: String, sellValue: int, rewardValue: int, flavorText: String, stackable: bool, amount: int) -> void:
	Name = itemName
	FlavorText = flavorText
	SellValue = sellValue
	RewardValue = rewardValue
	Stackable = stackable
	Amount = amount

func ItemByDict(ItemDict: Dictionary) -> void:
	Name = ItemDict["Name"]
	FlavorText = ItemDict["FlavorText"]
	SellValue = ItemDict["SellValue"]
	RewardValue = ItemDict["RewardValue"]
	Stackable = ItemDict["Stackable"]
	Amount = ItemDict["Amount"]

func getDifficulty():
	return SellValue

func printSelf():
	print(Name)
	print(str(SellValue))
	print(str(RewardValue))
	print(FlavorText)
	print(Stackable)