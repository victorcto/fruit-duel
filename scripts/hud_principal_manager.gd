extends Control

const FRUITS = ["Laranja", "Manga", "Maça", "Mangostão", "Pêssego"]

@onready var score_thrower_count: Label = $"Container/Score Thrower Container/Score Thrower Count"
@onready var random_fruits_label: Label = $"Container/Random Fruits Container/Random Fruits Label"
@onready var timer: Timer = $"Container/Random Fruits Container/Timer"
@onready var score_cutter_count = $"Container/Score Cutter Container/Score Cutter Count"

func _ready() -> void:
	score_thrower_count.text = str("%03d" % Globals.score_thrower)
	score_cutter_count.text = str("%03d" % Globals.score_cutter)
	timer.timeout.connect(_on_Timer_timeout)
	start_timer()

func _process(delta: float) -> void:
	score_thrower_count.text = str("%03d" % Globals.score_thrower)
	score_cutter_count.text = str("%03d" % Globals.score_cutter)

func start_timer():
	timer.wait_time = randf_range(1.0, 10.0)
	timer.start()

func _on_Timer_timeout():
	draw_fruits()
	start_timer()

func draw_fruits():
	var index = randi() % FRUITS.size()
	random_fruits_label.text = FRUITS[index]
	Globals.current_fruit = FRUITS[index]
