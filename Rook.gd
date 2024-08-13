extends Piece


@onready var destroy_timer : Timer = $DestroyTimer


func _ready() -> void:
	sprites = $Sprite
	global_position = Vector2(0, -1000)


func _physics_process(delta : float) -> void:
	var collision : KinematicCollision2D = move_and_collide(delta * dir)
	destroyed_animation(delta)
	if collision:
		collision.get_collider().destroyed()


func destroy() -> void:
	if !has_collided:
		has_collided = true
		destroy_timer.start()
		destroyed()
		dir = Vector2(0, 0)
