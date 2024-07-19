extends Piece


const knight_sprites : Dictionary = {
	[0, 0] : "res://chess_knight_facing_back.png",
	[2, 1] : "res://chess_knight_facing_back.png",
	[0, 1] : "res://chess_knight_facing_front.png",
	[2, 0] : "res://chess_knight_facing_front.png",
	[1, 0] : "res://chess_knight_f_h.png",
	[3, 1] : "res://chess_knight_f_h.png",
	[1, 1] : "res://chess_knight.png",
	[3, 0] : "res://chess_knight.png"
}


@onready var knight : Path2D = $"../.."
@onready var path_follow : PathFollow2D = $".."
@onready var knight_sprite : Sprite2D = $KnightSprite


func _ready() -> void:
	start(3)


func _physics_process(delta : float) -> void:
	path_follow.progress += speed * delta
	if path_follow.progress_ratio >= 1:
		start(rng.randi_range(0,3))
		path_follow.progress_ratio = 0


func start(option : int) -> void:
	knight.rotation = option * PI/2
	var knight_jump_direction : int = 0
	change_knight_parametrs(option, knight_jump_direction)


func change_knight_parametrs(option : int, jump_direction : int) -> void:
	if option == 0:
		knight.rotation = 0
		knight_sprite.rotation = 0
	elif option == 2:
		knight.rotation = PI
		knight_sprite.rotation = -PI
	elif option == 1:
		knight.rotation = PI/2
		knight_sprite.rotation = -PI/2
	elif option == 3:
		knight.rotation == -PI/2
		knight_sprite.rotation = PI/2
		
	if jump_direction == 0:
		knight.scale.y = -1
		if option == 0 || option == 2:
			knight_sprite.scale = Vector2(1, -1)
		else:
			knight_sprite.scale = Vector2(-1, 1)
	else:
		knight.scale.y = 1
		knight_sprite.scale = Vector2(1, 1)
	knight_sprite.texture = ResourceLoader.load(knight_sprites.get([option, jump_direction]))
