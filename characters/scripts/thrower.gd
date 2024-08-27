extends CharacterBody2D

var _state_machine
var _is_launch: bool = false
var _thrower_inside_area_fruit_1: bool = false
var _thrower_inside_area_fruit_2: bool = false
var _thrower_inside_area_fruit_3: bool = false
var _thrower_inside_area_fruit_4: bool = false
var _thrower_inside_area_fruit_5: bool = false
var shots = 1

@export_category("Variables")
@export var _move_speed: float = 64.0

@export var _friction: float = 0.2
@export var _acceleration: float = 0.2

@export_category("Objects")
@export var _animation_tree: AnimationTree = null

const FRUIT_1 = preload("res://prefabs/fruit_1.tscn")
const FRUIT_2 = preload("res://prefabs/fruit_2.tscn")
const FRUIT_3 = preload("res://prefabs/fruit_3.tscn")
const FRUIT_4 = preload("res://prefabs/fruit_4.tscn")
const FRUIT_5 = preload("res://prefabs/fruit_5.tscn")

var muzzle_velocity = 500.0
var bullet_gravity = 350.0

@onready var fruit_spawn_pointer: Marker2D = $fruit_spawn_pointer

func _ready() -> void:
	set_physics_process(false)
	_animation_tree.active = false
	_state_machine = _animation_tree["parameters/playback"]

func _physics_process(delta: float) -> void:
	_move()
	_animate()
	move_and_slide()
	aim()
	
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
	
func aim():
	fruit_spawn_pointer.look_at(get_global_mouse_position())

func _process(delta: float) -> void:
	Globals.shot_fruit = ""
	if _thrower_inside_area_fruit_1 and Input.is_action_just_released("throw"):
		throw_fruit1()
		
	if _thrower_inside_area_fruit_2 and Input.is_action_just_released("throw"):
		throw_fruit2()
		
	if _thrower_inside_area_fruit_3 and Input.is_action_just_released("throw"):
		throw_fruit3()
		
	if _thrower_inside_area_fruit_4 and Input.is_action_just_released("throw"):
		throw_fruit4()
		
	if _thrower_inside_area_fruit_5 and Input.is_action_just_released("throw"):
		throw_fruit5()

func _on_fruit_1_body_entered(body: Node2D) -> void:
	if body.name == "Thrower":
		_thrower_inside_area_fruit_1 = true

func _on_fruit_1_body_exited(body: Node2D) -> void:
	if body.name == "Thrower":
		_thrower_inside_area_fruit_1 = false

func _on_fruit_2_body_entered(body: Node2D) -> void:
	if body.name == "Thrower":
		_thrower_inside_area_fruit_2 = true

func _on_fruit_2_body_exited(body: Node2D) -> void:
	if body.name == "Thrower":
		_thrower_inside_area_fruit_2 = false

func _on_fruit_3_body_entered(body: Node2D) -> void:
	if body.name == "Thrower":
		_thrower_inside_area_fruit_3 = true
	
func _on_fruit_3_body_exited(body: Node2D) -> void:
	if body.name == "Thrower":
		_thrower_inside_area_fruit_3 = false

func _on_fruit_4_body_entered(body: Node2D) -> void:
	if body.name == "Thrower":
		_thrower_inside_area_fruit_4 = true

func _on_fruit_4_body_exited(body: Node2D) -> void:
	if body.name == "Thrower":
		_thrower_inside_area_fruit_4 = false

func _on_fruit_5_body_entered(body: Node2D) -> void:
	if body.name == "Thrower":
		_thrower_inside_area_fruit_5 = true
	
func _on_fruit_5_body_exited(body: Node2D) -> void:
	if body.name == "Thrower":
		_thrower_inside_area_fruit_5 = false
		
		
func throw_fruit1(): # MANGA
	var fruit1_instance = FRUIT_1.instantiate()
	get_tree().root.add_child(fruit1_instance)
	fruit1_instance.global_transform = fruit_spawn_pointer.global_transform
	fruit1_instance.velocity = fruit1_instance.transform.x * muzzle_velocity
	fruit1_instance.gravity = bullet_gravity
	
func throw_fruit2(): # PÊSSEGO
	var fruit2_instance = FRUIT_3.instantiate()
	get_tree().root.add_child(fruit2_instance)
	fruit2_instance.global_transform = fruit_spawn_pointer.global_transform
	fruit2_instance.velocity = fruit2_instance.transform.x * muzzle_velocity
	fruit2_instance.gravity = bullet_gravity
	
func throw_fruit3(): # MANGOSTÃO
	var fruit3_instance = FRUIT_4.instantiate()
	get_tree().root.add_child(fruit3_instance)
	fruit3_instance.global_transform = fruit_spawn_pointer.global_transform
	fruit3_instance.velocity = fruit3_instance.transform.x * muzzle_velocity
	fruit3_instance.gravity = bullet_gravity
	
func throw_fruit4(): # MAÇA
	var fruit4_instance = FRUIT_2.instantiate()
	get_tree().root.add_child(fruit4_instance)
	fruit4_instance.global_transform = fruit_spawn_pointer.global_transform
	fruit4_instance.velocity = fruit4_instance.transform.x * muzzle_velocity
	fruit4_instance.gravity = bullet_gravity

func throw_fruit5(): # LARANJA
	var fruit5_instance = FRUIT_5.instantiate()
	get_tree().root.add_child(fruit5_instance)
	fruit5_instance.global_transform = fruit_spawn_pointer.global_transform
	fruit5_instance.velocity = fruit5_instance.transform.x * muzzle_velocity
	fruit5_instance.gravity = bullet_gravity
	
func _stopOrStartCharacter(_is_active) -> void:
	set_physics_process(_is_active)
	_animation_tree.active = _is_active;
	
func start_pos(pos):
	position = pos
