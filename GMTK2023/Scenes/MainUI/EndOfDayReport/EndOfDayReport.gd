extends VBoxContainer
class_name EndOfDayReport

@onready var mainLogic = get_node("/root/GameLogic")
@onready var report = $QuestReport
@onready var label = $NoUpdate

signal report_finished

var updatedQuests: Array = []

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	label.hide()
	report.hide()
	report.go_next.connect(_go_next)
	mainLogic.state_changed.connect(_state_changed)

func _state_changed(_state: String, _playAnim: bool = true):
	if _state == "Sleep":
		fillUpdatedQuests()
		await get_tree().create_timer(0.5).timeout
		show()
		#print_debug(updatedQuests.size())
		if updatedQuests.size() > 0:
			report.show()
			label.hide()
			generateReport(0)
		else:
			print_debug("helo")
			report.hide()
			label.show()

func generateReport(questIndex: int) -> void:
	report.fill(updatedQuests[questIndex], questIndex)

func _go_next(previousQuestIndex: int):
	if updatedQuests[previousQuestIndex + 1]:
		generateReport(previousQuestIndex + 1)
	else:
		exitReport()

func exitReport() -> void:
	flushUpdatedQuests()
	report_finished.emit()
	await get_tree().create_timer(0.5).timeout
	hide()

func fillUpdatedQuests() -> void:
	updatedQuests = mainLogic.quests.getUpdatedQuests()
	#print_debug(updatedQuests)

func flushUpdatedQuests() -> void:
	updatedQuests = []
	mainLogic.quests.flushUpdatedQuests()

func _on_leave_button_pressed():
	exitReport()
