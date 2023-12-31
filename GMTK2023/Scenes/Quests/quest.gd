extends Node
class_name Quest

@export var id := 0
@export var defaultObjectiveScene = preload("res://Scenes/Quests/Objectives/objective.tscn")
@export var questName := "Default"
@export var expirationDate := 0
@export var difficulty := 0
@export var maxObjectives := 2
@export var taken := false

@export var adventurer: Adventurer

signal maximum_objective_reached(max)
signal objective_added(objective: Objective)
signal finished(quest: Quest)
signal failed(quest: Quest)
signal expired(quest: Quest)
signal took(quest: Quest)
# fired when something game related happen : quest picked up, objective tried by a hero...
signal something_happened(quest: Quest)
signal updated

# Called when the node enters the scene tree for the first time.
func _ready():
	Calendar.new_day.connect(_new_day)
	calcExpirationDate()

func setId(_id: int):
	id = _id

func setName(_name: String) -> void:
	questName = _name
	updated.emit()

func addObjective():
	if canHaveMoreObjective():
		var instance = defaultObjectiveScene.instantiate()
		instance.objective_finished.connect(_objective_finished)
		instance.objective_failed.connect(_objective_failed)
		instance.objective_modified.connect(_objective_modified)
		add_child(instance)
		calcExpirationDate()
		objective_added.emit(instance)
	else:
		maximum_objective_reached.emit(maxObjectives)

func getObjective(objectiveId: int) -> Node:
	for _i in self.get_children():
		if (_i.id == objectiveId):
			return _i
	return null

func sortById(obj_a, obj_b) -> bool:
	return true if obj_a.id > obj_b.id else false

func getAllObjectives() -> Array:
	var arr = get_children()
	arr.sort_custom(sortById)
	return arr

func tryNextObjective(heroSkill: int) -> void:
	var nxt = findNextObjective()
	nxt.tryObjective(heroSkill)
	something_happened.emit(self)

func findNextObjective() -> Objective:
	for _i in self.get_children():
		if _i.completed != true && _i.failed != true:
			return _i
	return null

func resetProgress() -> void:
	for _i in self.get_children():
		_i.completed = false

func canHaveMoreObjective() -> bool:
	return true if get_child_count() < maxObjectives else false

func _objective_finished(_objective: Objective) -> void:
	if isFinished():
		finished.emit(self)

func _objective_failed(_id: int) -> void:
	taken = false
	failed.emit(self)

func _objective_modified(_id: int) -> void:
	calcExpirationDate()

func calcExpirationDate() -> void:
	var expir = 0
	for _i in self.get_children():
		expir += _i.expirationDate
	expirationDate = expir

func calcDifficulty() -> void:
	var diff = 0
	for _i in self.get_children():
		diff += _i.calcDifficulty()
	difficulty = diff

func getDifficulty() -> int:
	calcDifficulty()
	return difficulty

func getValue() -> int:
	var val = 0
	for _i in self.get_children():
		val += _i.getValue()
	return val

func isFinished() -> bool:
	for _i in self.get_children():
		if _i.completed != true:
			return false
	return true

func _new_day(_nbr: int):
	expirationDate -= 1
	if expirationDate == 0:
		expired.emit(self)

func take(_adventurer: Adventurer) -> bool:
	if !taken:
		took.emit(self)
		taken = true
		findNextObjective().attempted = true
		findNextObjective().heroName =_adventurer.alias
		adventurer = _adventurer
		return true
	return false

func findFreeId():
	var ids: Array = []
	for _i in self.get_children():
		ids.append(_i.id)
	for _j in range(maxObjectives):
		if !ids.has(_j):
			return _j

func getName():
	return questName

func getAdventurer():
	return adventurer 
