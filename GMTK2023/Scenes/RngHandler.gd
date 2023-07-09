extends Node

@onready var gen: RandomNumberGenerator = RandomNumberGenerator.new()
const STARTER_GOLD_MIN = 20
const STARTER_GOLD_MAX = 40

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func generateSeed() -> void:
	gen.randomize()

func r(a: int, b: int) -> int:
	return gen.randi_range(a, b)

func generateStarterGold() -> int:
	return gen.randi_range(STARTER_GOLD_MIN, STARTER_GOLD_MAX)
