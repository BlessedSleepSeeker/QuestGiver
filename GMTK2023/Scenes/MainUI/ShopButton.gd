extends TextureButton

@onready var guildBtn = get_node("../GuildButton")
@onready var tavernBtn = get_node("../TavernButton")
@onready var active = $Active

signal shop_transition
# Called when the node enters the scene tree for the first time.
func _ready():
	guildBtn.guild_transition.connect(_leave)
	tavernBtn.tavern_transition.connect(_leave)

func _on_pressed():
	shop_transition.emit()
	await get_tree().create_timer(1).timeout
	active.show()

func _leave():
	await get_tree().create_timer(1).timeout
	active.hide()
