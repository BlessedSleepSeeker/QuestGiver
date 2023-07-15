extends HBoxContainer
class_name ObjectiveReport

@onready var textureCheck: TextureRect = $Status
@onready var textureCheckIcon: TextureRect = textureCheck.get_node("IconStatus")

@onready var textureType: TextureRect = $TextureType
@onready var textureChar: TextureRect = $TextureChar
@onready var textureReward: TextureRect = $TextureReward

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
		generateRewardIcon()

func generateStatusIcon():
	textureCheckIcon.texture = objective.getStatusIcon()
	textureCheckIcon.tooltip_text = objective.getStatusAsString()

func generateTypeIcon():
	if objective.type:
		textureType.get_node("IconType").texture = objective.type.getIcon()
		textureType.tooltip_text = objective.type.getTooltip()

func generateCharIcon():
	if objective.character:
		if objective.character.getIcon():
			textureChar.get_node("IconChar").texture = objective.character.getIcon()
		textureChar.tooltip_text = objective.character.getTooltip()

func generateRewardIcon():
	if objective.reward:
		textureReward.get_node("IconReward").texture = objective.reward.getIcon()
		textureReward.tooltip_text = objective.reward.getTooltip()
