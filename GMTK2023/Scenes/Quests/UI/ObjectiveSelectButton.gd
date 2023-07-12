extends TextureButton
class_name ObjectiveSelectButton

@export_enum("QUEST_TYPE", "CHAR", "ITEMS", "PLAYER_ITEMS") var buttonType: String = "QUEST_TYPE"
@onready var mainLogic = get_node("/root/GameLogic")
@onready var texture: TextureRect = $Texture
@onready var pickWindow: SelectObjectiveWindow = $SelectObjectiveWindow

signal open_window(type: String)
signal objective_selected(type: String, obj: Node)

# Called when the node enters the scene tree for the first time.
func _ready():
	loadType()
	pickWindow.objective_selected.connect(_objective_selected)

func loadType():
	match buttonType:
		"QUEST_TYPE": loadQuestType()
		"CHAR": loadCharacters()
		"ITEMS": loadItems()
		"PLAYER_ITEMS": loadPlayerItems()
	pickWindow.setWindowType(buttonType)
	pickWindow.generate()

func loadQuestType() -> void:
	pickWindow.setOption(mainLogic.getQuestTypes())

func loadCharacters() -> void:
	pickWindow.setOption(mainLogic.getCharacters())

func loadItems() -> void:
	pickWindow.setOption(mainLogic.getAllItems())

func loadPlayerItems() -> void:
	pickWindow.setOption(mainLogic.getPlayerItems())

func setTexture(_texture: Texture2D):
	texture.set_texture(_texture)

func updateIcon(_type: String, obj: Node):
	setTexture(obj.getIcon())

func _on_pressed():
	loadType()
	open_window.emit(buttonType)
	pickWindow.show()

func closeWindow():
	pickWindow.hide()

func _objective_selected(type: String, obj: Node):
	objective_selected.emit(type, obj)
	updateIcon(type, obj)
