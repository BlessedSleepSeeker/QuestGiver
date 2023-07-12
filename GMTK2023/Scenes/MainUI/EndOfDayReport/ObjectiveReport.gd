extends HBoxContainer

@onready var textureCheck: TextureRect = $Status
@onready var textureCheckIcon: TextureRect = textureCheck.get_node("StatusIcon")

@onready var buttonType: ObjectiveSelectButton = $ButtonType
@onready var buttonCharacter: ObjectiveSelectButton = $ButtonChar
@onready var buttonWantedItem: ObjectiveSelectButton = $ButtonWantedItem
@onready var buttonReward: ObjectiveSelectButton = $ButtonReward

@export var objective: Objective = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setObjective(obj: Objective):
	objective = obj

func generate():
	if objective:
		generateStatusIcon()
		generateTypeIcon()
		generateCharIcon()
		generateWantedIcon()
		generateRewardIcon()

func generateStatusIcon():
	textureCheckIcon.texture = objective.getStatusIcon()

func generateTypeIcon():
	pass

func generateCharIcon():
	pass

func generateWantedIcon():
	pass

func generateRewardIcon():
	pass