extends Area2D

var velocity := Vector2(100, 0)

signal hit_wall

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	position += velocity * delta
	rotation = velocity.angle()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("wall"):
		Globals.shot_fruit = "Manga"
		emit_signal("hit_wall")
		
	if area.is_in_group("attack_cutter") && Globals.current_fruit == 'Manga':
		Globals.score_cutter += 1;
	
	queue_free()
