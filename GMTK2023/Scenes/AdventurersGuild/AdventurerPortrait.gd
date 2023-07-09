extends Control

#@export var adv: Adventurer

@onready var lblName: Label = $Name
@onready var lblStatus: Label = $Status

# Called when the node enters the scene tree for the first time.
func _ready():
	pass



func fill(_adv: Adventurer) -> void:
	lblName.text = _adv.alias
	if _adv.getStatus():
		lblStatus.text = "is on a Quest !"
	else:
		lblStatus.text = "is drinking their sorrows..."
