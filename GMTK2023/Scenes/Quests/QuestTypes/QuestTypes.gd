extends Node
class_name QuestTypes

@export var questTypeList: Dictionary = {}
@export var defaultTypeScene = preload("res://Scenes/Quests/QuestTypes/QuestType.tscn")
@export var QUEST_TYPE_JSON_PATH = "res://Json/QuestTypes.json"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setQuestTypeList(dict: Dictionary):
	questTypeList = dict

func parseListFromJSON() -> void:
	var file = FileAccess.open(QUEST_TYPE_JSON_PATH, FileAccess.READ)
	var json_parsing = JSON.new()
	var error = json_parsing.parse(file.get_as_text())
	if error == OK:
		setQuestTypeList(json_parsing.data)
		loadFromQuestTypeList()
	else:
		print("JSON Parse Error:", json_parsing.get_error_message(), " in ", QUEST_TYPE_JSON_PATH, " at line ", json_parsing.get_error_line())

func loadFromQuestTypeList():
	for _i in questTypeList:
		var instance = defaultTypeScene.instantiate()
		instance.new(questTypeList[_i].Name, questTypeList[_i].Difficulty)
		add_child(instance)

func getQuestTypeByName(_name: String) -> QuestType:
	for _i in get_children():
		if _i.typeName == _name:
			return _i
	return null

func getAllAsDictionary():
	return questTypeList

func getAll():
	return self.get_children()
