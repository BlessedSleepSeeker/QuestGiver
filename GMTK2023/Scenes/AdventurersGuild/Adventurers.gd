extends Node
class_name Adventurers

@onready var mainLogic = get_parent()

@export var maxHeros = 3
@export var defaultHero = preload("res://Scenes/AdventurersGuild/Adventurer.tscn")

@export var HERO_NAME_JSON_PATH = "res://Json/HeroName.json"
var bulkHeroNames: Dictionary = {}
var heroClassList: Array

signal no_quest_to_take

# Called when the node enters the scene tree for the first time.
func _ready():
	parseHeroName()
	generateHeros()

func parseHeroName() -> void:
	var file = FileAccess.open(HERO_NAME_JSON_PATH, FileAccess.READ)
	var json_parsing = JSON.new()
	var error = json_parsing.parse(file.get_as_text())
	if error == OK:
		bulkHeroNames = json_parsing.data
		for _className in bulkHeroNames:
			heroClassList.append(_className)
	else:
		print("JSON Parse Error:", json_parsing.get_error_message(), " in ", HERO_NAME_JSON_PATH, " at line ", json_parsing.get_error_line())


func generateHeros() -> void:
	while getHerosNbr() < maxHeros:
		generateHero()
	#printAllHeros()

func getHerosNbr() -> int:
	var i := 0
	for _i in get_children():
		i += 1
	return i

func printAllHeros():
	for _i in get_children():
		_i.printSelf()

func generateHero() -> void:
	var instance = defaultHero.instantiate()
	var _class = generateHeroProfession()
	instance.new(
		_class,
		generateHeroName(_class),
		generateHeroSkill(),
		generateHeroTraits()
	)
	#instance.printSelf()
	add_child(instance)

func generateHeroProfession() -> String:
	return heroClassList[RngHandler.gen.randi_range(0, heroClassList.size() - 1)]

func generateHeroName(_class) -> String:
	return bulkHeroNames[_class][RngHandler.gen.randi_range(0, bulkHeroNames[_class].size() - 1)]

func generateHeroSkill() -> int:
	return RngHandler.gen.randi_range(10, 20)

func generateHeroTraits():
	return []

func everyoneLookForQuest():
	var quests = mainLogic.getQuests()
	if quests.is_empty():
		no_quest_to_take.emit()
	var curHeros = get_children()
	curHeros.shuffle()
	for _i in curHeros:
		for _j in quests:
			_i.lookForQuest(_j)

func everyoneProgressQuest():
	for _i in get_children():
		_i.progressQuest()
