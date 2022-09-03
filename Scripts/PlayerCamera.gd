extends Camera2D

const TRANS = Tween.TRANS_SINE
const EASE = Tween.EASE_IN_OUT

var amplitude = 0
onready var camera = get_node(".")

func _new_shake():
	var rand = Vector2()
	rand.x = rand_range(-amplitude, amplitude)
	rand.y = rand_range(-amplitude, amplitude)
	
	$ShakeTween.interpolate_property(
		camera, "offset", camera.offset, rand, 
		$Frequency.wait_time, TRANS, EASE)
	$ShakeTween.start()


func start_shake(duration = 0.2, freq = 15, amp = 3):
	self.amplitude = amp
	
	$Duration.wait_time = duration
	$Frequency.wait_time = 1 / float(freq)
	$Duration.start()
	$Frequency.start()

	_new_shake()


func _reset():
	$ShakeTween.interpolate_property(
		camera, "offset", camera.offset, Vector2(), 
		$Frequency.wait_time, TRANS, EASE)
	$ShakeTween.start()


func _on_ShakeTimer_timeout():
	_new_shake()


func _on_Duration_timeout():
	_reset()
	$Frequency.stop()
