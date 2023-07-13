extends TextureButton

@onready var guildBtn = get_node("../GuildButton")
@onready var tavernBtn = get_node("../TavernButton")
@onready var sleepBtn = get_node("../SleepButton/ConfirmationDialog")
@onready var active = $Active

signal shop_transition
# Called when the node enters the scene tree for the first time.
func _ready():
	guildBtn.guild_transition.connect(_leave)
	tavernBtn.tavern_transition.connect(_leave)
	sleepBtn.sleep_time.connect(_sleep)

func _sleep():
	active.show()

func _on_pressed():
	shop_transition.emit()
	await get_tree().create_timer(1).timeout
	active.show()

func _leave():
	await get_tree().create_timer(1).timeout
	active.hide()
