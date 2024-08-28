extends Control

const FRUITS = ["Laranja", "Manga", "Maça", "Mangostão", "Pêssego"]

@onready var score_thrower_count: Label = $"Container/Score Thrower Container/Score Thrower Count"
@onready var random_fruits_label: Label = $"Container/Random Fruits Container/Random Fruits Label"
@onready var timer: Timer = $"Container/Random Fruits Container/Timer"
@onready var score_cutter_count = $"Container/Score Cutter Container/Score Cutter Count"
@onready var clock_timer: Timer = $"Clock Timer"
@onready var timer_label: Label = $"Container/Timer Container/Timer Label"

signal time_is_up()

var minutes = 0
var seconds = 0
@export_range(0, 2) var default_minutes = 1
@export_range(0, 59) var default_seconds = 0

func _ready() -> void:
	score_thrower_count.text = str("%03d" % Globals.score_thrower)
	score_cutter_count.text = str("%03d" % Globals.score_cutter)
	timer.timeout.connect(_on_Timer_timeout)
	start_timer()
	timer_label.text = str("%02d" % default_minutes) + ":" + str("%02d" % default_seconds)
	reset_clock_timer()

func _process(delta: float) -> void:
	score_thrower_count.text = str("%03d" % Globals.score_thrower)
	score_cutter_count.text = str("%03d" % Globals.score_cutter)
	
	if minutes == 0 and seconds == 0:
		if Globals.score_cutter > Globals.score_thrower:
			Globals.winner_name = "Cutter"
		elif Globals.score_cutter < Globals.score_thrower:
			Globals.winner_name = "Thrower"
		else:
			Globals.winner_name = "Tie"
		
		emit_signal("time_is_up")

func start_timer():
	timer.wait_time = randf_range(1.0, 20.0)
	timer.start()

func _on_Timer_timeout():
	draw_fruits()
	start_timer()

func draw_fruits():
	var index = randi() % FRUITS.size()
	random_fruits_label.text = FRUITS[index]
	Globals.current_fruit = FRUITS[index]

func _on_clock_timer_timeout() -> void:
	if seconds == 0:
		if minutes > 0:
			minutes -= 1
			seconds = 60
	seconds -= 1 
	
	timer_label.text = str("%02d" % minutes) + ":" + str("%02d" % seconds) 
	
func reset_clock_timer():
	minutes = default_minutes
	seconds = default_seconds
