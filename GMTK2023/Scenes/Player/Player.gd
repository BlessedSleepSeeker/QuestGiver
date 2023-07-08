extends Node
class_name Player

var Name: String = "Default"
var reputationLevel: int = 1
var reputationName := {0: "Not Affiliated", 1: "On-Trial Questmaker", 2: "Official Questmaker", 3: "Appreciated Questmaker", 4: "Respected Questmaker", 5:"Legendary Questmaker"}
var reputationXp := 0
var reputationXpPerLevel := {0: 0, 1: 10, 2: 10, 3: 70, 4: 300, 5: 1000}

@onready var inventory = $"Inventory"

func _ready():
	pass # Replace with function body.

func addGold(nbr: int):
	inventory.addGold(nbr)