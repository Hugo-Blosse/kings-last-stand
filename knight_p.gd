extends Path2D
class_name KnightPath

@onready var static_body_2d : Piece = $PathFollow/StaticBody2D


func start_option() -> void:
	static_body_2d.start_option()


func set_speed(speed : int) -> void:
	static_body_2d.speed = speed
