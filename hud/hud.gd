extends CanvasLayer

signal start_game
@onready var message_label = $Control/VBoxContainer/MessageLabel
@onready var messager_timer = $MessagerTimer
@onready var start_button = $Control/VBoxContainer/StartButton
@onready var credits_button = $Control/VBoxContainer/CreditsButton
@onready var quit_button = $Control/VBoxContainer/QuitButton
@onready var cutter = $"../Cutter"
@onready var thrower = $"../Thrower"


func show_message(text):
	message_label.text = text
	message_label.show()
	messager_timer.start()
	await messager_timer.timeout
	
func show_game_over():
	show_message("Game Over")
	cutter._stopOrStartCharacter(false);
	thrower._stopOrStartCharacter(false);
	await messager_timer.timeout
	
	message_label.text = "Fruit Duel"
	message_label.show()
	
	await get_tree().create_timer(1.0).timeout
	start_button.show()
	credits_button.show()
	quit_button.show()

func _on_start_button_pressed():
	message_label.hide()
	start_button.hide()
	credits_button.hide()
	quit_button.hide()
	start_game.emit()


func _on_messager_timer_timeout():
	message_label.hide()


func _on_credits_button_pressed():
	get_tree().change_scene_to_file("res://hud/controls_screen.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
