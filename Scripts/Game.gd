extends Node

var timer
var timer_state
enum t_states { ACTIVE, INACTIVE }

func _ready():
	timer = 0.0
	timer_state = t_states.INACTIVE


func _process(_delta):
	if $ActiveScene.get_child(0).name == "Title" && timer_state == t_states.INACTIVE:
		timer = 0.0
		$TimerText.text = "00:00.0"
	
	if $ActiveScene.get_child(0).name == "Level1" && timer_state == t_states.INACTIVE:
		$Timer.start()
		timer_state = t_states.ACTIVE
	
	if $ActiveScene.get_child(0).name == "EndScene" && timer_state == t_states.ACTIVE:
		$Timer.stop()
		timer_state = t_states.INACTIVE


func _on_Timer_timeout():
	var minutes = int(timer / 60 / 10)
	var seconds = int(timer / 10) % 60
	var miliseconds = int(timer) % 10

	var time = ("%02d" % minutes) + (":%02d" % seconds) + (".%1d" % miliseconds)
	$TimerText.text = time
	timer += 1.0
