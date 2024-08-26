extends Control

var fruits = ["Manga", "Laranja", "Pêssego", "Maça", "Mangostão"]

@onready var label = $Label
@onready var timer = $Timer

func _ready():
	timer.timeout.connect(_on_Timer_timeout)
	start_timer()

func start_timer():
	timer.wait_time = randf_range(1.0, 5.0)
	timer.start()

func _on_Timer_timeout():
	draw_fruits()
	start_timer()

func draw_fruits():
	var index = randi() % fruits.size()
	label.text = fruits[index]
