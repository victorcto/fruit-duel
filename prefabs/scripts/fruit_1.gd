extends Area2D

var velocity := Vector2(200, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	position += velocity * delta
	rotation = velocity.angle()
