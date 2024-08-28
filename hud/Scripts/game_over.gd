extends Control

@onready var winner: Label = $VBoxContainer/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	Globals.shot_fruit = ""
	Globals.current_fruit = ""
	Globals.score_cutter = 0
	Globals.score_thrower = 0
	if Globals.winner_name == "Tie":
		winner.text = Globals.winner_name + "!!!"
	else: 
		winner.text = "Congratulations, " + Globals.winner_name + "!!!"

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_restart_pressed() -> void:
	get_tree().change_scene_to_file("res://levels/scenes/test_level.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
