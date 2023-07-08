extends Node
class_name QuestCalendar

var current_day := 1
var seasons_str = {1: "Spring", 2: "Summer" , 3: "Autumn", 4: "Winter"}
var current_season := 1
var year := 1
var loan_day := 1

const current_day_str := "Day %s of %s, Year %s"

signal new_day(nbr)
signal new_season(season)
signal new_year(nbr)
signal loan_time

const DAY_PER_SEASON = 15
const LOAN_REPETITION = 7

func getCurrentDay() -> String:
	return current_day_str % [current_day, seasons_str[current_season], year]

func progressSeason() -> void:
	current_season += 1
	if current_season > 4:
		year += 1
		current_season = 1
		new_year.emit(year)
	new_season.emit(current_season)
	

func addDay() -> void:
	current_day += 1
	checkLoan()
	if (current_day > DAY_PER_SEASON):
		current_day = 1
		progressSeason()
	new_day.emit(current_day)

func GetRemainingLoanDay() -> int:
	return LOAN_REPETITION - loan_day

func checkLoan() -> void:
	loan_day += 1
	if LOAN_REPETITION < loan_day:
		loan_day = 1