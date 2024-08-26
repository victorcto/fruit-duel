extends Control

@onready var score_thrower_count: Label = $"Container/Score Thrower Container/Score Thrower Count"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	score_thrower_count.text = str("%03d" % Globals.score_thrower)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	score_thrower_count.text = str("%03d" % Globals.score_thrower)
