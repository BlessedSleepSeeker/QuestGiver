extends TextureButton

@onready var shopBtn = get_node("../ShopButton")
@onready var tavernBtn = get_node("../TavernButton")
@onready var sleepBtn = get_node("../SleepButton/ConfirmationDialog")
@onready var active = $Active

signal guild_transition
# Called when the node enters the scene tree for the first time.
func _ready():
	shopBtn.shop_transition.connect(_leave)
	tavernBtn.tavern_transition.connect(_leave)
	sleepBtn.sleep_time.connect(_sleep)
	active.hide()

func _sleep():
	active.hide()

func _on_pressed():
	guild_transition.emit()
	await get_tree().create_timer(1).timeout
	active.show()


func _leave():
	await get_tree().create_timer(1).timeout
	active.hide()