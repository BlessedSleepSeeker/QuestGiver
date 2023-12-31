extends HBoxContainer


@export var objective: Objective
signal modified(obj: Objective)

@onready var textureCheck: TextureRect = $Status
@onready var textureCheckIcon: TextureRect = textureCheck.get_node("StatusIcon")

@onready var buttonType: ObjectiveSelectButton = $ButtonType
@onready var buttonLandmark: ObjectiveSelectButton = $ButtonChar
@onready var buttonReward: ObjectiveSelectButton = $ButtonReward

var status: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	connectToButton(buttonType)
	connectToButton(buttonLandmark)
	connectToButton(buttonReward)

func connectToObjective():
	if !objective.updated.is_connected(_objective_updated):
		objective.updated.connect(_objective_updated)

func connectToButton(btn: ObjectiveSelectButton):
	btn.open_window.connect(_open_window, true)
	btn.objective_selected.connect(_objective_selected)
	btn.loadType()

func setObjective(obj: Objective) -> void:
	objective = obj
	generate()

func generate() -> void:
	generateStatusIcon()
	if objective:
		if objective.type:
			buttonType.updateUI(objective.type)
		if objective.landmark:
			buttonLandmark.updateUI(objective.landmark)
		if objective.reward:
			buttonReward.updateUI(objective.reward)

func setInteraction(_interactible: bool):
	_interactible = !_interactible
	buttonType.disabled = _interactible
	buttonLandmark.disabled = _interactible
	buttonReward.disabled = _interactible

func generateStatusIcon() -> void:
	match objective.getStatus():
		0: textureCheckIcon.texture = null
		1: textureCheckIcon.texture = objective.exclamationIcon
		2: textureCheckIcon.texture = objective.cancelIcon
		3: textureCheckIcon.texture = objective.okIcon

#don't question it
func _open_window(_type):
	if _type != buttonType.buttonType:
		buttonType.closeWindow()
	if _type != buttonLandmark.buttonType:
		buttonLandmark.closeWindow()
	if _type != buttonReward.buttonType:
		buttonReward.closeWindow()

func _objective_selected(_type: String, obj: Node):
	match _type:
		"QUEST_TYPE": objective.setType(obj)
		"CHAR": objective.setLandmark(obj)
		"PLAYER_ITEMS": objective.setReward(obj)

#callback if needed
func _objective_updated():
	pass
