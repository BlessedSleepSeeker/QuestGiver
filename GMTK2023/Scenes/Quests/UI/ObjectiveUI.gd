extends HBoxContainer


@export var objective: Objective
signal modified(obj: Objective)

@onready var textureCheck: TextureRect = $Status
@onready var textureCheckIcon: TextureRect = textureCheck.get_node("StatusIcon")

@onready var buttonType: ObjectiveSelectButton = $ButtonType
@onready var buttonCharacter: ObjectiveSelectButton = $ButtonChar
@onready var buttonWantedItem: ObjectiveSelectButton = $ButtonWantedItem
@onready var buttonReward: ObjectiveSelectButton = $ButtonReward

@export var okIcon: Texture2D = preload("res://Sprites/UI/Movement/okIcon.png")
@export var cancelIcon: Texture2D = preload("res://Sprites/UI/Movement/cancelcon.png")
@export var exclamationIcon: Texture2D = preload("res://Sprites/UI/Movement/exclamationIcon.png")
var status: Dictionary

# Called when the node enters the scene tree for the first time.
func _ready():
	connectToButton(buttonType)
	connectToButton(buttonCharacter)
	connectToButton(buttonWantedItem)
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
	generateIcon()
	if objective:
		buttonType.updateIcon(buttonType.buttonType, objective.type)
		if objective.character:
			buttonCharacter.updateIcon(buttonCharacter.buttonType, objective.character.characterName)
		if objective.wantedItem:
			buttonWantedItem.updateIcon(buttonWantedItem.buttonType, objective.wantedItem.Name)
		if objective.reward:
			buttonReward.updateIcon(buttonReward.buttonType, objective.reward.Name)

func setInteraction(_interactible: bool):
	_interactible = !_interactible
	buttonType.disabled = _interactible
	buttonCharacter.disabled = _interactible
	buttonWantedItem.disabled = _interactible
	buttonReward.disabled = _interactible

func generateIcon() -> void:
	var _status = objective.getStatus()
	if _status == 0:
		textureCheckIcon.texture = null
	elif _status == 1:
		textureCheckIcon.texture = exclamationIcon
	elif _status == 2:
		textureCheckIcon.texture = cancelIcon
	elif _status == 3:
		textureCheckIcon.texture = okIcon

#don't question it
func _open_window(_type):
	if _type != buttonType.buttonType:
		buttonType.closeWindow()
	if _type != buttonCharacter.buttonType:
		buttonCharacter.closeWindow()
	if _type != buttonWantedItem.buttonType:
		buttonWantedItem.closeWindow()
	if _type != buttonReward.buttonType:
		buttonReward.closeWindow()

func _objective_selected(_type: String, objName: String):
	if _type == "QUEST_TYPE":
		objective.setType(objName)
	elif _type == "CHAR":
		objective.setCharacterByName(objName)
	elif _type == "ITEMS":
		objective.setItemByName(objName, false)
	elif _type == "PLAYER_ITEMS":
		objective.setItemByName(objName, true)

#callback if needed
func _objective_updated():
	pass
