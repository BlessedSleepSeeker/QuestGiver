extends TextureButton

@onready var guildBtn = get_node("../GuildButton")
@onready var shopBtn = get_node("../ShopButton")
@onready var active = $Active

signal tavern_transition
# Called when the node enters the scene tree for the first time.
func _ready():
	guildBtn.guild_transition.connect(_leave)
	shopBtn.shop_transition.connect(_leave)
	active.hide()

func _on_pressed():
	tavern_transition.emit()
	await get_tree().create_timer(0.7).timeout
	active.show()

func _leave():
	await get_tree().create_timer(0.7).timeout
	active.hide()
