extends Node

var current_scene
var next_scene = ""

func change_scene(old_scene, new_scene):
	current_scene = old_scene
	print(new_scene)
	next_scene = load(new_scene).instance()
	$AnimationPlayer.play("scene_fade_out")

func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "scene_fade_out":
		current_scene.queue_free()
		get_node("/root/Game/ActiveScene").add_child(next_scene)
		$AnimationPlayer.play("scene_fade_in")
