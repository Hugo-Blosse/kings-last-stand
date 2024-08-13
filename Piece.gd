extends StaticBody2D
class_name Piece


@export var pos_val : int = 800
@export var speed : int = 200
@export var destroy_speed : int = 0


var rng : RandomNumberGenerator = RandomNumberGenerator.new()
var dir : Vector2
var sprites : Node2D
var has_collided : bool = false


func start(option : int) -> void:
	has_collided = false
	var vect : Vector2 = Vector2((option % 2) * (2 - option), ((option + 1) % 2) * (1 - option))
	global_position = vect * pos_val
	dir = -vect * speed


func destroyed() -> void:
	destroy_speed = 1


func destroyed_animation(delta : float) -> void:
	if destroy_speed != 0:
		for sprite in sprites.get_children():
			sprite.position += sprite.offset  * destroy_speed * delta
			sprite.material.set("shader_parameter/alpha", (sprite.material.get("shader_parameter/alpha") - delta))


func _on_destroy_timer_timeout() -> void:
	destroy_speed = 0
	global_position = Vector2(0, -1000)
	for sprite in sprites.get_children():
		sprite.position = Vector2(0, 0)
		sprite.material.set("shader_parameter/alpha", 1.0)


func destroy() -> void:
	pass


func start_option() -> void:
	start(rng.randi_range(0,3))
