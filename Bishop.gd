extends Piece


var has_changed_position : bool = false


func _ready() -> void:
	start(0)


func _physics_process(delta : float) -> void:
	var collision : KinematicCollision2D = move_and_collide(delta * dir)
	if (abs(global_position.x) <= 200 && abs(global_position.y) <= 200) && !has_changed_position:
		has_changed_position = true
		global_position = -global_position
		dir = -dir
	if collision || (global_position.x != 0 && global_position.y != 0):
		has_changed_position = false
		start(rng.randi_range(0,3))

