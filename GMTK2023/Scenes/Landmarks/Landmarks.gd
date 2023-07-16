extends Node
class_name Landmarks

@export var landmarkList: Dictionary = {}
@export var CHAR_JSON_PATH = "res://Json/Landmarks.json"
@export var defaultLandmark = preload("res://Scenes/Landmarks/Landmark.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setLandmarkList(dict: Dictionary):
	landmarkList = dict

func parseListFromJSON() -> void:
	var file = FileAccess.open(CHAR_JSON_PATH, FileAccess.READ)
	var json_parsing = JSON.new()
	var error = json_parsing.parse(file.get_as_text())
	if error == OK:
		setLandmarkList(json_parsing.data)
		loadFromLandmarkList()
	else:
		print("JSON Parse Error:", json_parsing.get_error_message(), " in ", CHAR_JSON_PATH, " at line ", json_parsing.get_error_line())

func loadFromLandmarkList():
	for _i in landmarkList:
		var instance = defaultLandmark.instantiate()
		instance.new(landmarkList[_i].Name, landmarkList[_i].FlavorText, landmarkList[_i].Type, landmarkList[_i].Difficulty, landmarkList[_i].IconFileName)
		add_child(instance)

func getLandmarkByName(_name: String) -> Landmark:
	for _i in get_children():
		if _i.landmarkName == _name:
			return _i
	return null

func getAllAsDictionary():
	return landmarkList

func getAll():
	return self.get_children()
