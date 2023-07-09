extends Node
class_name Characters

@export var characters := {}
@export var defaultCharacter = preload("res://Scenes/Characters/Character.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setCharacterList(dict: Dictionary):
	characters = dict

func loadFromCharacterList():
	for _i in characters:
		var instance = defaultCharacter.instantiate()
		instance.new(characters[_i].Name, characters[_i].Difficulty)
		add_child(instance)

func getCharacterByName(_name: String) -> Character:
	for _i in get_children():
		if _i.characterName == _name:
			return _i
	return null

func getAllAsDictionary():
	return characters
