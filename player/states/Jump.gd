extends BaseState


@export var move_speed := 60.0

@export var fall_node : NodePath
@export var walk_node : NodePath
@export var run_node : NodePath
@export var idle_node : NodePath


@onready var fall_state : BaseState = get_node(fall_node)
@onready var walk_state : BaseState = get_node(walk_node)
@onready var run_state : BaseState = get_node(run_node)
@onready var idle_state : BaseState = get_node(idle_node)


func enter() -> void:
	super()
	player.velocity.y = player.jump_velocity
	

func physics_process(delta: float) -> BaseState:
	var move = 0
	if Input.is_action_pressed("move_left"):
		move = -1
		player.animated_sprite_2d.flip_h = true
	elif Input.is_action_pressed("move_right"):
		move = 1
		player.animated_sprite_2d.flip_h = false
	
	player.velocity.x = move * move_speed
	player.velocity.y += player.gravity * delta
	player.move_and_slide()
	
	if player.velocity.y > 0:
		return fall_state

	if player.is_on_floor():
		if move != 0:
			if Input.is_action_pressed("run"):
				return run_state
			return walk_state
		return idle_state
	return null
