extends HBoxContainer
class_name ObjectiveReport

@onready var textureCheck: TextureRect = $Status
@onready var textureCheckIcon: TextureRect = textureCheck.get_node("StatusIcon")

@onready var buttonType: ObjectiveSelectButton = $ButtonType
@onready var buttonCharacter: ObjectiveSelectButton = $ButtonChar
@onready var buttonWanted: ObjectiveSelectButton = $ButtonWanted
@onready var buttonReward: ObjectiveSelectButton = $ButtonReward

@export var objective: Objective = null

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func setObjective(obj: Objective):
	objective = obj
	generate()

func generate():
	if objective:
		generateStatusIcon()
		generateTypeIcon()
		generateCharIcon()
		generateWantedIcon()
		generateRewardIcon()

func generateStatusIcon():
	textureCheckIcon.get_node("IconStatus").texture = objective.getStatusIcon()
	textureCheckIcon.tooltip_text = objective.getStatusAsString()

func generateTypeIcon():
	if objective.type:
		buttonType.get_node("IconType").texture = objective.type.getIcon()
		buttonType.tooltip_text = objective.type.getTooltip()

func generateCharIcon():
	buttonCharacter.get_node("IconChar").texture = objective.character.getIcon()
	buttonType.tooltip_text = objective.character.getTooltip()

func generateWantedIcon():
	buttonWanted.get_node("IconWanted").texture = objective.wanted.getIcon()
	buttonType.tooltip_text = objective.wanted.getTooltip()

func generateRewardIcon():
	buttonReward.get_node("IconReward").texture = objective.reward.getIcon()
	buttonType.tooltip_text = objective.reward.getTooltip()
