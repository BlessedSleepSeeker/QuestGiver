extends Node
class_name Objective

@onready var mainLogic = get_node("/root/GameLogic")

@export_group("Mechanics")
@export var id := 0
@export var expirationDate := 5

@export var type: QuestType = null
@export var character: Character = null
@export var wanted: Item = null
@export var reward: Item = null

@export var completed: bool = false
@export var failed: bool = false
@export var attempted: bool = false
@export var difficulty: int = 0

signal updated
signal objective_finished(objective: Objective)
signal objective_failed(objective: Objective)
signal objective_modified(objective: Objective)

@export_group("Textures")
@export var okIcon: Texture2D = preload("res://Sprites/UI/Movement/okIcon.png")
@export var cancelIcon: Texture2D = preload("res://Sprites/UI/Movement/cancelcon.png")
@export var exclamationIcon: Texture2D = preload("res://Sprites/UI/Movement/exclamationIcon.png")

@export var QuestTypePath: String = "res://Sprites/UI/Quests/Objective/%s.png"


var IconPathSmall: String
var IconPath: String


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func new(_id: int, _type: QuestType, _wanted: Item, _character: Character):
	setId(_id)
	setType(_type)
	setWanted(_wanted)
	setCharacter(_character)

func setId(_id):
	id = _id
	updated.emit()

func setType(_type: QuestType):
	type = _type
	updated.emit()

func setWanted(_wanted: Item):
	wanted = _wanted
	updated.emit()

func setCharacter(_character: Character):
	character = _character
	updated.emit()

func setReward(_reward: Item):
	reward = _reward
	updated.emit()

func getValue() -> int:
	if reward:
		return reward.getValue()
	return 0

func calcDifficulty():
	var a = 0
	var b = 0
	if wanted:
		a = wanted.getDifficulty()
	if character:
		b = character.getDifficulty()
	return (a + b)

func tryObjective(heroSkill: int) -> bool:
	if RngHandler.gen.randi_range(1, 100) + heroSkill > calcDifficulty():
		completed = true
		objective_finished.emit(self)
		return true
	failed = true
	objective_failed.emit(self)
	return false

func setCharacterByName(_name: String,):
	character = mainLogic.getCharacterByName(_name)
	updated.emit()

# false is item
# true is reward
func setItemByName(_name: String, isReward: bool):
	if isReward:
		reward = mainLogic.getItemFromPlayer(_name)
	else:
		wanted = mainLogic.getwanted(_name)
	updated.emit()

func getStatus() -> int:
	if completed:
		return 3
	elif failed:
		return 2
	elif attempted:
		return 1
	return 0

func getStatusAsString() -> String:
	match getStatus():
		0: return "Not undertaken up yet"
		1: return "%s will rise to the challenge" % "A hero"
		2: return "%s failed" % "A hero"
		3: return "%s did it !" % "A hero"
	return "error: unknown status"

func getStatusIcon() -> Texture2D:
	match getStatus():
		0: return null
		1: return exclamationIcon
		2: return cancelIcon
		3: return okIcon
	return null

func getIconFor(_step: String) -> Texture2D:
	match (_step):
		"QUEST_TYPE":
			if type:
				return type.getIcon()
		"CHAR":
			if character:
				return character.getIcon()
		"ITEMS":
			if wanted:
				return wanted.getIcon()
		"PLAYER_ITEMS":
			if reward:
				return reward.getIcon()
	return null

func getFlavorTextFor(_step: String) -> String:
	match (_step):
		"QUEST_TYPE":
			return type.typeName
		"CHAR":
			return character.getFlavorText()
		"ITEMS":
			return wanted.getFlavorText()
		"PLAYER_ITEMS":
			return reward.getFlavorText()
	return "༼ つ ◕_◕ ༽つ Something went wrong. Here's an easter egg to cover for it. ༼ つ ◕_◕ ༽つ"
