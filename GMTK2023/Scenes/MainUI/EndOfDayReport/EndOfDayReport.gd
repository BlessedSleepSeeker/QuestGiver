extends Container
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

func _state_changed(_state):
	if _state == mainLogic.STATE.Sleep:
		fillUpdatedQuests()
		show()
		if updatedQuests.size() > 0:
			report.show()
			label.hide()
			generateReport(0)
		else:
			report.hide()
			label.show()

func generateReport(questIndex: int) -> void:
	report.fill(updatedQuests[questIndex], questIndex)

func _go_next(previousQuestIndex: int):
	if updatedQuests[previousQuestIndex + 1]:
		generateReport(previousQuestIndex + 1)
	else:
		exitReport()

func exitReport():
	flushUpdatedQuests()
	report_finished.emit()

func fillUpdatedQuests():
	updatedQuests = mainLogic.quests.getUpdatedQuests()

func flushUpdatedQuests():
	updatedQuests = []
