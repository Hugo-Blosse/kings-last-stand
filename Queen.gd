extends Node2D
class_name Queen


@export var speed : int = 5


var queen_pos : float


@onready var static_body_2d : StaticBody2D = $StaticBody2D


func _input(event : InputEvent) -> void:
	if Input.is_action_just_pressed("a"):
		if queen_pos == PI:
			rotation = -PI
		queen_pos = -PI/2
	if Input.is_action_just_pressed("w"):
		queen_pos = 0
	if Input.is_action_just_pressed("d"):
		queen_pos = PI/2
	if Input.is_action_just_pressed("s"):
		if queen_pos == -PI/2:
			rotation = 3*PI/2
		queen_pos = PI


func _physics_process(delta : float) -> void:
	rotation = move_toward(rotation, queen_pos, speed * delta)
	static_body_2d.rotation = -rotation

