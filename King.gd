extends StaticBody2D
class_name King


@export var destroy_speed : int = 0


signal game_over()


@onready var sprites : Node2D = $Sprite


func _physics_process(delta : float) -> void:
	destroyed_animation(delta)


func destroyed() -> void:
	destroy_speed = 1
	emit_signal("game_over")


func destroyed_animation(delta : float) -> void:
	if destroy_speed != 0:
		for sprite in sprites.get_children():
			sprite.position += sprite.offset  * destroy_speed * delta
			sprite.material.set("shader_parameter/alpha", (sprite.material.get("shader_parameter/alpha") - delta))

