extends CharacterBody2D

var _state_machine
var _is_attacking: bool = false

@export_category("Variables")
@export var _move_speed: float = 64.0

@export var _friction: float = 0.2
@export var _acceleration: float = 0.2

@export_category("Objects")
@export var _animation_tree: AnimationTree = null

func _ready() -> void:
	_animation_tree.active = true;
	_state_machine = _animation_tree["parameters/playback"]

func _physics_process(delta: float) -> void:
	_move()
	_animate()
	move_and_slide()	
	
func _move() -> void:
	var _direction: Vector2 = Vector2(
		Input.get_axis("move_left_thrower", "move_right_thrower"),
		Input.get_axis("move_up_thrower", "move_down_thrower")
	)
	
	if _direction != Vector2.ZERO:
		_animation_tree["parameters/idle/blend_position"] = _direction
		_animation_tree["parameters/walk/blend_position"] = _direction
		
		velocity.x = lerp(velocity.x, _direction.normalized().x * _move_speed, _acceleration)
		velocity.y = lerp(velocity.y, _direction.normalized().y * _move_speed, _acceleration)
		return
		
	velocity.x = lerp(velocity.x, _direction.normalized().x * _move_speed, _friction)
	velocity.y = lerp(velocity.y, _direction.normalized().y * _move_speed, _friction)
	
	velocity = _direction.normalized() * _move_speed

func _animate() -> void:
	if velocity.length() > 10:
		_state_machine.travel("walk")
		return
		
	_state_machine.travel("idle")
