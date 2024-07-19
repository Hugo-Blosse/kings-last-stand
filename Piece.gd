extends StaticBody2D
class_name Piece


@export var pos_val : int = 800
@export var speed : int = 200


var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var dir : Vector2


func start(option : int) -> void:
	var vect : Vector2 = Vector2((option % 2) * (2 - option), ((option + 1) % 2) * (1 - option))
	global_position = vect * pos_val
	dir = -vect * speed
