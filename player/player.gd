extends CharacterBody2D
class_name Player


@onready var state_machine: StateMachine = $StateMachine
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

@export var move_speed := 60.0
@export var jump_height := 50.0
@export var jump_peak_time := 0.4
@export var jump_descent_time := 0.35
@onready var gravity = ((-2.0 * jump_height) / (jump_peak_time * jump_peak_time)) * -1.0
@onready var fall_gravity = ((-2.0 * jump_height) / (jump_descent_time * jump_descent_time)) * -1.0
@onready var jump_velocity = ((2.0 * jump_height) / (jump_peak_time)) * -1.0

func _ready() -> void:
	state_machine.init(self)

func _unhandled_input(event: InputEvent) -> void:
	state_machine.unhandled_input(event)

func _process(delta: float) -> void:
	state_machine.process(delta)

func _physics_process(delta: float) -> void:
	state_machine.physics_process(delta)
