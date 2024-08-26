extends Area2D

var velocity := Vector2(100, 0)

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	position += velocity * delta
	rotation = velocity.angle()
