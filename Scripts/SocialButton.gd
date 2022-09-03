extends TouchScreenButton

export (String) var url

func _on_LinkButton_pressed():
	OS.shell_open(url)
