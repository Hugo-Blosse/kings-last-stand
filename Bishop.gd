extends Piece


var has_changed_position : bool = false


@onready var destroy_timer : Timer = $DestroyTimer


func _ready() -> void:
	sprites = $Sprite
	global_position = Vector2(0, 1000)


func _physics_process(delta : float) -> void:
	var collision : KinematicCollision2D = move_and_collide(delta * dir)
	if collision:
		collision.get_collider().destroyed()
	destroyed_animation(delta)
	if (abs(global_position.x) <= 180 && abs(global_position.y) <= 180) && !has_changed_position:
		has_changed_position = true
		global_position = -global_position
		dir = -dir


func destroy() -> void:
	if !has_collided:
		has_collided = true
		destroy_timer.start()
		destroyed()
		dir = Vector2(0, 0)


func _on_destroy_timer_timeout() -> void:
	destroy_speed = 0
	has_changed_position = false
	global_position = Vector2(0, 1000)
	for sprite in sprites.get_children():
		sprite.position = Vector2(0, 0)
		sprite.material.set("shader_parameter/alpha", 1.0)
