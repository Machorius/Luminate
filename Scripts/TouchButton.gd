extends TouchScreenButton

export (String) var button_text
export (String) var next_scene_res


# Called when the node enters the scene tree for the first time.
func _ready():
	$RichTextLabel.text = button_text

func _on_TouchButton_pressed():
	get_node("/root/Game/SceneManager").change_scene(get_parent(), next_scene_res)
