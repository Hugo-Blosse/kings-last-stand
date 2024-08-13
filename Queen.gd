extends Node2D
class_name Queen


@export var speed : int = 5


signal piece_destroyed()


var queen_pos : float


@onready var area_2d : Area2D = $Area2D


func _input(_event : InputEvent) -> void:
	if Input.is_action_just_pressed("a"):
		if rotation >= PI/2:
			queen_pos = 3*PI/2
		else:
			queen_pos = -PI/2
	if Input.is_action_just_pressed("w"):
		if rotation >= PI:
			queen_pos = 2*PI
		else:
			queen_pos = 0
	if Input.is_action_just_pressed("d"):
		if rotation >= 3*PI/2:
			queen_pos = 5*PI/2
		else:
			queen_pos = PI/2
	if Input.is_action_just_pressed("s"):
		queen_pos = PI


func _physics_process(delta : float) -> void:
	rotation = move_toward(rotation, queen_pos, speed * delta)
	if rotation >= 2*PI:
		rotation -= 2*PI
		queen_pos -= 2*PI
	elif rotation < 0:
		rotation += 2*PI
		queen_pos += 2*PI
	area_2d.rotation = -rotation


func _on_area_2d_body_entered(body : Piece) -> void:
	body.destroy()
	emit_signal("piece_destroyed")
