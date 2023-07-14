extends VBoxContainer
class_name EndOfDayReport

@onready var mainLogic = get_node("/root/GameLogic")
@onready var report = $VB/C/HB/Marg/QuestReport
@onready var label = $CenterContainer/Label
@onready var nextQuestButton = $VB/C/HB/C2/NextButton
@onready var prevQuestButton = $VB/C/HB/C/PrevButton

signal report_finished

var updatedQuests: Array = []
var index: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	nextQuestButton.pressed.connect(_nextQuest)
	prevQuestButton.pressed.connect(_prevQuest)
	mainLogic.state_changed.connect(_state_changed)

func _state_changed(_state: String, _playAnim: bool = true):
	if _state == "Sleep":
		await get_tree().create_timer(0.5).timeout
		fillUpdatedQuests()
		generateReport()
		show()

func generateReport() -> void:
	flushReport()
	generateUI()
	if updatedQuests.size() > 0:
		report.fill(updatedQuests[index])

func generateUI() -> void:
	generateLabel()
	generateReportUI()

func generateLabel() -> void:
	if updatedQuests.size() < 1:
		label.text = "There was no update today"
	if updatedQuests.size() == 1:
		label.text = "Only this quest was updated"
	if updatedQuests.size() > 1:
		label.text = "Quest %d/%d was updated" % [index + 1, updatedQuests.size()]

func generateReportUI() -> void:
	if updatedQuests.size() < 1:
		report.hide()
		nextQuestButton.hide()
		prevQuestButton.hide()
	if updatedQuests.size() == 1:
		report.show()
		nextQuestButton.hide()
		prevQuestButton.hide()
	if updatedQuests.size() > 1:
		report.show()
		nextQuestButton.show()
		prevQuestButton.show()

func flushReport() -> void:
	report.flushObjectives()

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

func _nextQuest():
	if index + 1 < updatedQuests.size():
		index += 1
		generateReport()
	else:
		index = 0
		generateReport()

func _prevQuest():
	if index > 0:
		index -= 1
		generateReport()
	else:
		index = updatedQuests.size() - 1
		generateReport()
