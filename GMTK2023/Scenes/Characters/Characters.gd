extends Node
class_name Characters

@export var characterList: Dictionary = {}
@export var CHAR_JSON_PATH = "res://Json/Characters.json"
@export var defaultCharacter = preload("res://Scenes/Characters/Character.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setCharacterList(dict: Dictionary):
	characterList = dict

func parseListFromJSON() -> void:
	var file = FileAccess.open(CHAR_JSON_PATH, FileAccess.READ)
	var json_parsing = JSON.new()
	var error = json_parsing.parse(file.get_as_text())
	if error == OK:
		setCharacterList(json_parsing.data)
		loadFromCharacterList()
	else:
		print("JSON Parse Error:", json_parsing.get_error_message(), " in ", CHAR_JSON_PATH, " at line ", json_parsing.get_error_line())

func loadFromCharacterList():
	for _i in characterList:
		var instance = defaultCharacter.instantiate()
		instance.new(characterList[_i].Name, characterList[_i].FlavorText, characterList[_i].Type, characterList[_i].Difficulty, characterList[_i].IconFileName)
		add_child(instance)

func getCharacterByName(_name: String) -> Character:
	for _i in get_children():
		if _i.characterName == _name:
			return _i
	return null

func getAllAsDictionary():
	return characterList

func getAll():
	return self.get_children()
