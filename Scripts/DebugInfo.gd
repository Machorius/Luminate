extends RichTextLabel


func _process(_delta):
	var current_scene = get_parent().get_node("ActiveScene").get_child(0)
	if ("debug_data" in current_scene):
		text = str(current_scene.debug_data)
	else:
		text = str(current_scene)
