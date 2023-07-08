extends GridContainer

var rows := 6
var slots := columns * rows

@export var itemButton := preload("res://Scenes/Items/ItemIcon.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	for i in slots:
		var instance = itemButton.instantiate()
		instance.setName("DefaultItem")
		add_child(instance)
