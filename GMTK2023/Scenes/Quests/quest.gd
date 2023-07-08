extends Node
class_name Quest

@export var defaultObjectiveScene = preload("res://Scenes/Quests/Objectives/objective.tscn")

var max_objective := 2
signal maximum_objective_reached(max)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func addObjective():
	if canHaveMoreObjective():
		var instance = defaultObjectiveScene.instanciate()
		add_child(instance)
	else:
		maximum_objective_reached.emit(max_objective)

func getObjective(objectiveId: int) -> Node:
	for _i in self.get_children():
		if (_i.id == objectiveId):
			#print("found %s!" % itemKey)
			return _i
	return null

func canHaveMoreObjective() -> bool:
	return true if get_child_count() < max_objective else false