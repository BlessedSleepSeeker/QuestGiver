extends Node
class_name Objective

@onready var mainLogic = get_node("/root/GameLogic")

@export_group("Mechanics")
@export var id := 0
@export var expirationDate := 5

@export var type: QuestType = null
@export var landmark: Landmark = null
@export var reward: Item = null

@export var completed: bool = false
@export var failed: bool = false
@export var attempted: bool = false
@export var difficulty: int = 0

@export var heroName: String = ""

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

func new(_id: int, _type: QuestType, _landmark: Landmark):
	setId(_id)
	setType(_type)
	setLandmark(_landmark)

func setId(_id):
	id = _id
	updated.emit()

func setType(_type: QuestType):
	type = _type
	updated.emit()

func setLandmark(_landmark: Landmark):
	landmark = _landmark
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
	if landmark:
		b = landmark.getDifficulty()
	return (a + b)

func tryObjective(heroSkill: int) -> bool:
	if RngHandler.gen.randi_range(1, 100) + heroSkill > calcDifficulty():
		completed = true
		objective_finished.emit(self)
		return true
	failed = true
	objective_failed.emit(self)
	return false

func setLandmarkByName(_name: String,):
	landmark = mainLogic.getLandmarkByName(_name)
	updated.emit()

# false is item
# true is reward
func setItemByName(_name: String):
	reward = mainLogic.getItemFromPlayer(_name)
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
		1: return "%s will rise to the challenge" % heroName
		2: return "%s failed..." % heroName
		3: return "%s did it !" % heroName
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
			if landmark:
				return landmark.getIcon()
		"PLAYER_ITEMS":
			if reward:
				return reward.getIcon()
	return null

func getFlavorTextFor(_step: String) -> String:
	match (_step):
		"QUEST_TYPE":
			return type.typeName
		"CHAR":
			return landmark.getFlavorText()
		"PLAYER_ITEMS":
			return reward.getFlavorText()
	return "༼ つ ◕_◕ ༽つ Something went wrong. Here's an easter egg to cover for it. ༼ つ ◕_◕ ༽つ"
