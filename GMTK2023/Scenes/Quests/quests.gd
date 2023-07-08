extends Node
class_name Quests

@export var maxQuests = 3
@export var defaultQuestScene = preload("res://Scenes/Quests/quest.tscn")

signal maximum_quest_reached
signal quest_added(quest: Quest)
signal quest_finished(quest: Quest)
signal quest_failed(quest: Quest)
signal quest_expired(quest: Quest)
signal quest_took(quest: Quest)


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func addQuest():
	if canHaveMoreQuest():
		var instance = defaultQuestScene.instanciate()
		instance.finished.connect(_quest_finished)
		instance.failed.connect(_quest_failed)
		instance.expired.connect(_quest_expired)
		instance.took.connect(_quest_took)
		quest_added.emit(instance)
		add_child(instance)
	else:
		maximum_quest_reached.emit(maxQuests)

func findFreeId():
	var ids: Array = []
	for _i in self.get_children():
		ids.append(_i.id)
	for _j in range(maxQuests):
		if !ids.has(_j):
			return _j

func canHaveMoreQuest():
	return true if get_child_count() < maxQuests else false

func _quest_finished(quest: Quest) -> void:
	quest_finished.emit(quest)

func _quest_failed(quest: Quest) -> void:
	quest_failed.emit(quest)

func _quest_expired(quest: Quest) -> void:
	quest_expired.emit(quest)

func _quest_took(quest: Quest) -> void:
	quest_took.emit(quest)

func getQuestById(id: int) -> Quest:
	for _i in self.get_children():
		if _i.id == id:
			return _i
	return null