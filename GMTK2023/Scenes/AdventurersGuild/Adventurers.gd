extends Node
class_name Adventurers

@onready var mainLogic = get_parent()

@export var maxHeros = 3
@export var defaultHero = preload("res://Scenes/AdventurersGuild/Adventurer.tscn")

var heroNames: Array = ["megreth", "hokore", "ulidali", "izor", "nirass", "umashann", "errovys", "igorin", "ivys", "ikonn"]

signal no_quest_to_take

# Called when the node enters the scene tree for the first time.
func _ready():
	#parseHeroName()
	generateHeros()

# func parseHeroName() -> void:
# 	var file = FileAccess.open(QUEST_TYPE_JSON_PATH, FileAccess.READ)
# 	var json_parsing = JSON.new()
# 	var error = json_parsing.parse(file.get_as_text())
# 	if error == OK:
# 		questTypes = json_parsing.data
# 		#print(questTypes)
# 	else:
# 		print("JSON Parse Error:", json_parsing.get_error_message(), " in ", ITEMS_JSON_PATH, " at line ", json_parsing.get_error_line())


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
	instance.new(
		generateHeroName(),
		generateHeroSkill(),
		generateHeroTraits()
	)
	add_child(instance)

func generateHeroName() -> String:
	return heroNames[RngHandler.gen.randi_range(0, heroNames.size() - 1)]

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
	print(quests)
	for _i in curHeros:
		for _j in quests:
			_i.lookForQuest(_j)

func everyoneProgressQuest():
	for _i in get_children():
		_i.progressQuest()
