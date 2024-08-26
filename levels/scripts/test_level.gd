extends Node2D

func game_over():
	$HUD.show_game_over()
	$Cutter.start_pos($StartPositionCutter.position)

func new_game():
	await $HUD.show_message("Get Ready!")
	$Cutter._stopOrStartCharacter(true)
