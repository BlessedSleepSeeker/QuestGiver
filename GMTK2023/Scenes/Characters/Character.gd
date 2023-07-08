extends Node
class_name Character

@export var characterName: String = "DefaultCharacter"
@export var difficulty: int = 0


func New(_charName: String, _difficulty: int):
	setName(_charName)
	setDifficulty(_difficulty)

func setName(_charName: String):
	characterName = _charName

func setDifficulty(_difficulty):
	difficulty = _difficulty

func getDifficulty():
	return difficulty
