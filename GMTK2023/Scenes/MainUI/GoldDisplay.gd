extends HBoxContainer

@onready var playerInventory = get_node("/root/GameLogic/Player/Inventory")
@onready var labl = $NbrGold

# Called when the node enters the scene tree for the first time.
func _ready():
	playerInventory.gold_added.connect(add_gold)
	playerInventory.gold_removed.connect(remove_gold)
	updateGoldCount()

func add_gold(_nbr: int):
	updateGoldCount()

func remove_gold(_nbr: int):
	updateGoldCount()

func updateGoldCount():
	labl.text = str(playerInventory.gold)
