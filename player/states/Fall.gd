extends BaseState


@export var move_speed := 60.0
@export var run_node : NodePath
@export var walk_node : NodePath
@export var idle_node : NodePath

@onready var run_state: BaseState = get_node(run_node)
@onready var walk_state: BaseState = get_node(walk_node)
@onready var idle_state: BaseState = get_node(idle_node)

func physics_process(delta: float) -> BaseState:
	var move = 0
	if Input.is_action_pressed("move_left"):
		move = -1
		player.animated_sprite_2d.flip_h = true
	elif Input.is_action_pressed("move_right"):
		move = 1
		player.animated_sprite_2d.flip_h = false
	
	player.velocity.x = move * move_speed
	print_debug(player.velocity.y)
	apply_gravity(delta)
	player.move_and_slide()

	if player.is_on_floor():
		if move != 0:
			if Input.is_action_pressed("run"):
				return run_state
			return walk_state
		else:
			return idle_state
	return null


func apply_gravity(delta):
	if player.velocity.y > 200.0 : return
	player.velocity.y += player.fall_gravity * delta
	
