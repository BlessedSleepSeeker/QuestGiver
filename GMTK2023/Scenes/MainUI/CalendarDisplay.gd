extends HBoxContainer

@onready var labl = $Label

# Called when the node enters the scene tree for the first time.
func _ready():
	Calendar.new_day.connect(new_day)
	labl.text = Calendar.getCurrentDay()

func new_day(_nbr: int):
	update_date()

func update_date():
	await get_tree().create_timer(1).timeout
	labl.text = Calendar.getCurrentDay()