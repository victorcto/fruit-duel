extends CanvasLayer

signal start_game
@onready var message_label = $Control/VBoxContainer/MessageLabel
@onready var messager_timer = $MessagerTimer
@onready var start_button = $Control/VBoxContainer/StartButton

func show_message(text):
	message_label.text = text
	message_label.show()
	messager_timer.start()
	
func show_game_over():
	show_message("Game Over")
	await messager_timer.timeout
	
	message_label.text = "Fruit Duel"
	message_label.show()
	
	await get_tree().create_timer(1.0).timeout
	start_button.show()
	

func _on_start_button_pressed():
	start_button.hide()
	start_game.emit()


func _on_messager_timer_timeout():
	message_label.hide()
