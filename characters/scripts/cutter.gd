extends CharacterBody2D

var _state_machine
var _is_attacking: bool = false

@export_category("Variables")
@export var _move_speed: float = 64.0

@export var _friction: float = 0.2
@export var _acceleration: float = 0.2

@export_category("Objects")
@export var _attack_timer: Timer = null
@export var _animation_tree: AnimationTree = null

func _ready() -> void:
	set_physics_process(false)
	_animation_tree.active = false;
	_animation_tree.anim_player
	_state_machine = _animation_tree["parameters/playback"]

func _physics_process(delta: float) -> void:
	_move()
	_attack()
	_animate()
	move_and_slide()
	
func _move() -> void:
	var _direction: Vector2 = Vector2(
		Input.get_axis("move_left", "move_right"),
		Input.get_axis("move_up", "move_down")
	)
	
	if _direction != Vector2.ZERO:
		_animation_tree["parameters/idle/blend_position"] = _direction
		_animation_tree["parameters/walk/blend_position"] = _direction
		_animation_tree["parameters/attack/blend_position"] = _direction
		
		velocity.x = lerp(velocity.x, _direction.normalized().x * _move_speed, _acceleration)
		velocity.y = lerp(velocity.y, _direction.normalized().y * _move_speed, _acceleration)
		return
		
	velocity.x = lerp(velocity.x, _direction.normalized().x * _move_speed, _friction)
	velocity.y = lerp(velocity.y, _direction.normalized().y * _move_speed, _friction)
	
	velocity = _direction.normalized() * _move_speed

func _attack() -> void:
	if Input.is_action_just_pressed("cut") and not _is_attacking:
		_attack_timer.start()
		_is_attacking = true

func _animate() -> void:
	if _is_attacking:
		_state_machine.travel("attack")
		return
		
	if velocity.length() > 10:
		_state_machine.travel("walk")
		return
		
	_state_machine.travel("idle")


func _on_attack_timer_timeout() -> void:
	_is_attacking = false;


func _on_attack_area_body_entered(body) -> void:
	pass # Replace with function body.

func _stopOrStartCharacter(_is_active) -> void:
	set_physics_process(_is_active)
	_animation_tree.active = _is_active;
		
func start_pos(pos):
	position = pos
