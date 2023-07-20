extends BaseState
class_name MoveState

@export var move_speed := 60.0

@export var jump_node : NodePath
@export var fall_node : NodePath
@export var walk_node : NodePath
@export var run_node : NodePath
@export var dash_node : NodePath
@export var idle_node : NodePath


@onready var jump_state : BaseState = get_node(jump_node)
@onready var fall_state : BaseState = get_node(fall_node)
@onready var walk_state : BaseState = get_node(walk_node)
@onready var run_state : BaseState = get_node(run_node)
@onready var dash_state : BaseState = get_node(dash_node)
@onready var idle_state : BaseState = get_node(idle_node)


func unhandled_input(event: InputEvent) -> BaseState:
	if Input.is_action_just_pressed("jump"):
		return jump_state
	
	if Input.is_action_just_pressed("dash"):
		return dash_state

	return null


func physics_process(delta: float) -> BaseState:
	if !player.is_on_floor():
		return fall_state

	var move = get_movement_input()
	if move < 0:
		player.animated_sprite_2d.flip_h = true
	elif move > 0:
		player.animated_sprite_2d.flip_h = false
	
	player.velocity.y += player.gravity * delta
	player.velocity.x = move * move_speed
	player.move_and_slide()
	
	if move == 0:
		return idle_state

	return null

func get_movement_input() -> int:
	if Input.is_action_pressed("move_left"):
		return -1
	elif Input.is_action_pressed("move_right"):
		return 1
	
	return 0
