extends Node2D


var enemies_defeated : int = 0
var enemies_to_spawn : int = 4
var options : Array = []
var selected_pieces : Array = []
var pieces_to_select : Dictionary
var piece_speed : int = 200
var queen_speed : int = 5
var rng : RandomNumberGenerator = RandomNumberGenerator.new()


@onready var queen : Queen = $Queen
@onready var label : Label = $Control/Label
@onready var label_2 : Label = $Control/HBoxContainer/Label2
@onready var pieces : Node = $Pieces
@onready var spawn_timer : Timer = $SpawnTimer


func _ready() -> void:
	for i in range(pieces.get_children().size()):
		options.append(i)
	pieces_to_select = {
		0: $Pieces/Bishop1,
		1: $Pieces/Bishop2,
		2: $Pieces/Bishop3,
		3: $Pieces/Bishop4,
		4: $Pieces/Knight1,
		5: $Pieces/Knight2,
		6: $Pieces/Knight3,
		7: $Pieces/Knight4,
		8: $Pieces/Rook1,
		9: $Pieces/Rook2,
		10: $Pieces/Rook3,
		11: $Pieces/Rook4,
	}
	game_start()


func _on_king_game_over() -> void:
	label.visible = true
	label_2.visible = true
	save_high_score(get_high_score())
	set_speed(0, 0)


func get_high_score() -> int:
	var save_file := FileAccess.open("res://save.save", FileAccess.READ)
	return save_file.get_line().to_int()


func save_high_score(highest_score : int) -> void:
	if highest_score < enemies_defeated:
		var high_score := FileAccess.open("res://save.save", FileAccess.WRITE)
		high_score.store_line(str(enemies_defeated))
		label_2.text = str("Highest score: ", enemies_defeated)
	else:
		label_2.text = str("Highest score: ", highest_score)


func _on_queen_piece_destroyed() -> void:
	enemies_defeated += 1
	enemies_to_spawn -= 1
	if enemies_to_spawn <= 0:
		$RoundTimer.start()
	label.text = str("Enemies defeated: ", enemies_defeated)


func game_start() -> void:
	enemies_to_spawn = 4
	selected_pieces = []
	spawn_timer.wait_time = 1
	queen_speed = 5
	set_speed(0, queen_speed)
	piece_speed = 200
	create_pieces()


func create_pieces() -> void:
	var options_list : Array = options
	for i in range(enemies_to_spawn):
		var num : int = rng.randi_range(0, options_list.size() - 1)
		selected_pieces.append(pieces_to_select[options_list[num]])
		options_list.erase(num)
	spawn_timer.start()


func _on_spawn_timer_timeout() -> void:
	set_selected_speed(piece_speed)
	selected_pieces[0].start_option()
	selected_pieces.erase(selected_pieces[0])
	if selected_pieces.size() > 0:
		spawn_timer.start()


func _on_round_timer_timeout() -> void:
	piece_speed += 20
	queen_speed += 1
	enemies_to_spawn = rng.randi_range(5, 8)
	create_pieces()


func set_speed(p_s : int, q_s : int) -> void:
	for piece in pieces.get_children():
		if piece is KnightPath:
			piece.set_speed(p_s)
		else:
			piece.speed = p_s
	queen.speed = q_s


func set_selected_speed(p_s : int) -> void:
	if selected_pieces[0] is KnightPath:
		selected_pieces[0].set_speed(p_s)
	else:
		selected_pieces[0].speed = p_s

