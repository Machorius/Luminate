extends Node2D

var ball_scene = preload("res://Objects/Ball.tscn")

enum level_states {PLAY, COMPLETE}
var current_state = level_states.PLAY
var current_level

func _ready():
	current_level = name
	current_level.erase(0,5)
	print(current_level)
	set_physics_process(true)
	current_state = level_states.PLAY
	var new_ball = ball_scene.instance()
	$AllBalls.add_child(new_ball)

func _process(_delta):
	for ball in $AllBalls.get_children():
		if ball.position.y > 1800 or ball.position.x < -500 or ball.position.x > 2320:
			if check_win() and current_state == level_states.PLAY:
				
				if int(current_level) == 5:
					get_node("/root/Game/SceneManager").change_scene(
						get_node("."), "res://Scenes/EndScene.tscn")
					current_state = level_states.COMPLETE
					get_node("/root/Game/LevelComplete").play()
				else:
					get_node("/root/Game/SceneManager").change_scene(
						get_node("."), "res://Scenes/Levels/Level" + str(int(current_level) + 1) + ".tscn")
					current_state = level_states.COMPLETE
					get_node("/root/Game/LevelComplete").play()
				
			else:
				ball.queue_free()
				spawn_new_ball()
				reset_all_blocks()


func check_win():
	for block in $AllBlocks.get_children():
		if !block.is_active:
			return false
	return true


func reset_all_blocks():
	for block in $AllBlocks.get_children():
		block.set_inactive()


func spawn_new_ball():
	var new_ball = ball_scene.instance()
	$AllBalls.add_child(new_ball)
