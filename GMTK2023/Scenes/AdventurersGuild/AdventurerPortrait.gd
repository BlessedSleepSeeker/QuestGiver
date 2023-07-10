extends Control

#@export var adv: Adventurer

@onready var lblStatus: Label = $Status

var status: String = ""

# Called when the node enters the scene tree for the first time.
func _ready():
	pass



func fill(_adv: Adventurer) -> void:
	lblStatus.text = "%s the lvl %d %s %s" % [_adv.getAlias(), _adv.getSkill(), _adv.getProfession(), _adv.getStatusAsString()]
