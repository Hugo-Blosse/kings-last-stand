extends Piece


const knight_sprites : Dictionary = {
	[0, 0] : "u",
	[2, 1] : "u",
	[0, 1] : "d",
	[2, 0] : "d",
	[1, 0] : "r",
	[3, 1] : "r",
	[1, 1] : "l",
	[3, 0] : "l"
}


var knight_jump_direction : int


@onready var knight : Path2D = $"../.."
@onready var path_follow : PathFollow2D = $".."
@onready var destroy_timer : Timer = $DestroyTimer


func _ready() -> void:
	sprites = $Sprite
	speed = 0


func _physics_process(delta : float) -> void:
	path_follow.progress += speed * delta
	destroyed_animation(delta)
	if path_follow.progress_ratio >= 1:
		var dir2 : Vector2 = dir * speed * -1 * ( 2 * (knight_jump_direction - 0.5))
		var collision : KinematicCollision2D = move_and_collide(dir2 * delta)
		if collision:
			collision.get_collider().destroyed()
			position = Vector2.ZERO
			start(rng.randi_range(0,3))
			path_follow.progress_ratio = 0


func start(option : int) -> void:
	has_collided = false
	dir = Vector2((option % 2) * (2 - option), ((option + 1) % 2) * (1 - option) * -1)
	knight.rotation = option * PI/2
	knight_jump_direction = rng.randi_range(0,1)
	change_knight_parametrs(option, knight_jump_direction)


func change_knight_parametrs(option : int, jump_direction : int) -> void:
	if option == 0:
		knight.rotation = 0
		sprites.rotation = 0
	elif option == 2:
		knight.rotation = PI
		sprites.rotation = -PI
	elif option == 1:
		knight.rotation = PI/2
		sprites.rotation = -PI/2
	elif option == 3:
		knight.rotation = -PI/2
		sprites.rotation = PI/2

	if jump_direction == 0:
		if option == 0 || option == 2:
			sprites.scale = Vector2(1, -1)
		else:
			sprites.scale = Vector2(-1, 1)
		knight.scale.y = -1
	else:
		knight.scale.y = 1
		sprites.scale = Vector2(1, 1)

	for i in range(1, sprites.get_children().size() + 1):
		var knight_sprite : Sprite2D = sprites.get_node(str("Sprite", i))
		knight_sprite.texture = ResourceLoader.load((str("res://Art/knight", knight_sprites.get([option, jump_direction]), i, ".png")))


func destroy() -> void:
	if !has_collided:
		has_collided = true
		destroy_timer.start()
		destroyed()
		speed = 0


func _on_destroy_timer_timeout() -> void:
	position = Vector2.ZERO
	destroy_speed = 0
	path_follow.progress = 0
	for sprite in sprites.get_children():
		sprite.position = Vector2(0, 0)
		sprite.material.set("shader_parameter/alpha", 1.0)

