extends Piece


func _ready() -> void:
	start(0)


func _physics_process(delta : float) -> void:
	var collision : KinematicCollision2D = move_and_collide(delta * dir)
	if collision || (global_position.x != 0 && global_position.y != 0):
		start(rng.randi_range(0,3))
