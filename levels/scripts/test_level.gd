extends Node2D

@onready var wall_area: Area2D = $"Wall/Wall Area"

func game_over():
	pass
	#$HUD.show_game_over()
	#$Cutter.start_pos($StartPositionCutter.position)
	#$Thrower.start_pos($StartPositionThrower.position)

func new_game():
	await $HUD.show_message("Get Ready!")
	$Cutter._stopOrStartCharacter(true)
	$Thrower._stopOrStartCharacter(true)

func _ready() -> void:
	wall_area.connect("area_entered", Callable(self, "_on_wall_area_area_entered"))

func _on_wall_area_area_entered(area: Area2D) -> void:	
	if area.is_in_group("fruits"):
		area.connect("hit_wall", Callable(self, "_on_fruit_hit_wall"))

func _on_fruit_hit_wall() -> void:
	if Globals.score_thrower < 0:
		Globals.score_thrower = 0;
	
	if Globals.shot_fruit == Globals.current_fruit and Globals.shot_fruit != "":
		Globals.score_thrower += 1;
	elif Globals.shot_fruit != "":
		Globals.score_thrower -= 1;
		
	if Globals.score_thrower < 0:
		Globals.score_thrower = 0;
		
	
