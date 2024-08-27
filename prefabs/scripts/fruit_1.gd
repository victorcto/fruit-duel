extends Area2D

var velocity := Vector2(200, 0)
signal hit_wall
@onready var score_cutter_count = $"HUD Principal/Control/Container/Score Cutter Container/Score Cutter Count"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	position += velocity * delta
	rotation = velocity.angle()

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("wall"):
		Globals.shot_fruit = "Laranja"
		emit_signal("hit_wall")
		queue_free()
	
	if area.is_in_group("attack_cutter"):
		Globals.score_cutter += 1;
		print(str("%03d" % Globals.score_cutter))
		#score_cutter_count.text = "001"
		#score_cutter_count.text = str("%03d" % Globals.score_cutter)
		queue_free()
