extends Control

const FRUITS = ["Manga", "Laranja", "Pêssego", "Maça", "Mangostão"]

@onready var score_thrower_count: Label = $"Container/Score Thrower Container/Score Thrower Count"
@onready var random_fruits_label: Label = $"Container/Random Fruits Container/Random Fruits Label"
@onready var timer: Timer = $"Container/Random Fruits Container/Timer"

func _ready() -> void:
	score_thrower_count.text = str("%03d" % Globals.score_thrower)
	timer.timeout.connect(_on_Timer_timeout)
	start_timer()

func _process(delta: float) -> void:
	score_thrower_count.text = str("%03d" % Globals.score_thrower)
	if Globals.shot_fruit == Globals.current_fruit and Globals.shot_fruit != "":
		Globals.score_thrower += 1;
	elif Globals.shot_fruit != "":
		Globals.score_thrower -= 1;
	
	if Globals.score_thrower < 0:
		Globals.score_thrower = 0;

func start_timer():
	timer.wait_time = randf_range(1.0, 5.0)
	timer.start()

func _on_Timer_timeout():
	draw_fruits()
	start_timer()

func draw_fruits():
	var index = randi() % FRUITS.size()
	random_fruits_label.text = FRUITS[index]
	Globals.current_fruit = FRUITS[index]
