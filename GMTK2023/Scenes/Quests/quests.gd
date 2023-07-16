extends Node
class_name Quests

@export var maxQuests = 3
@export var defaultQuestScene := preload("res://Scenes/Quests/quest.tscn")

signal maximum_quest_reached
signal quest_added(quest: Quest)
signal quest_finished(quest: Quest)
signal quest_failed(quest: Quest)
signal quest_expired(quest: Quest)
signal quest_took(quest: Quest)

@export var updatedQuests: Array[Quest] = []
@export var discoveredLandmarks: Array[Landmark] = []
@export var lootedLandmarks: Array[Landmark] = []

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func printQuestsId() -> void:
	for _i in self.get_children():
		print(_i.id)

func addQuest() -> Quest:
	if canHaveMoreQuest():
		var instance = defaultQuestScene.instantiate()
		instance.setId(findFreeId())
		instance.finished.connect(_quest_finished)
		instance.failed.connect(_quest_failed)
		instance.expired.connect(_quest_expired)
		instance.took.connect(_quest_took)
		instance.something_happened.connect(_quest_happened)
		quest_added.emit(instance)
		add_child(instance)
		return instance
	else:
		maximum_quest_reached.emit(maxQuests)
	return null

func findFreeId() -> int:
	var ids: Array = []
	for _i in self.get_children():
		ids.append(_i.id)
	for _j in range(maxQuests):
		if !ids.has(_j):
			return _j
	return -1

func sortById(obj_a, obj_b) -> bool:
	return true if obj_a.id > obj_b.id else false

func getAll() -> Array:
	var arr = get_children()
	arr.sort_custom(sortById)
	return arr

func canHaveMoreQuest() -> bool:
	return true if get_child_count() < maxQuests else false

func _quest_finished(quest: Quest) -> void:
	quest_finished.emit(quest)

func _quest_failed(quest: Quest) -> void:
	quest_failed.emit(quest)

func _quest_expired(quest: Quest) -> void:
	quest_expired.emit(quest)

func _quest_took(quest: Quest) -> void:
	quest_took.emit(quest)
	addToUpdatedQuests(quest)

func _quest_happened(quest: Quest) -> void:
	addToUpdatedQuests(quest)

func getQuestById(id: int) -> Quest:
	for _i in self.get_children():
		if _i.id == id:
			return _i
	return null

func addToUpdatedQuests(_quest: Quest):
	if updatedQuests.has(_quest) == false:
		updatedQuests.append(_quest)

func getUpdatedQuests() -> Array[Quest]:
	return updatedQuests

func flushUpdatedQuests() -> void:
	updatedQuests = []

func addToDiscoveredLandmarks(_landmark: Landmark):
	if discoveredLandmarks.has(_landmark) == false:
		discoveredLandmarks.append(_landmark)

func getDiscoveredLandmarks() -> Array[Landmark]:
	return discoveredLandmarks

func addToLootedLandmarks(_landmark: Landmark):
	if lootedLandmarks.has(_landmark) == false:
		lootedLandmarks.append(_landmark)

func getLootedLandmarks() -> Array[Landmark]:
	return lootedLandmarks