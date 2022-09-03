extends Node

var bg_tracks = [
	preload("res://Audio/BgGtr1.mp3"),
	preload("res://Audio/BgGtr2.mp3"),
	preload("res://Audio/BgGtr3.mp3"),
	preload("res://Audio/BgGtr4.mp3"),
	preload("res://Audio/BgGtr5.mp3"),
	preload("res://Audio/BgGtr6.mp3"),
	preload("res://Audio/BgGtr7.mp3"),
	preload("res://Audio/BgGtr8.mp3")
]

var bg_track_1
var bg_track_2

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	
	bg_track_1 = bg_tracks[rand_range(0, 7)]
	bg_track_2 = bg_tracks[rand_range(0, 7)]
	
	while bg_track_1 == bg_track_2:
		bg_track_2 = bg_tracks[rand_range(0, 7)]
	
	$BgStream1.stream = bg_track_1
	$BgStream2.stream = bg_track_2
	$BgStream1.play()

func _on_BgStream1_finished():
	randomize()
	bg_track_1 = bg_tracks[rand_range(0, 7)]
	$BgStream1.stop()
	$BgStream1.stream = bg_track_1
	$BgStream2.play()


func _on_BgStream2_finished():
	randomize()
	bg_track_2 = bg_tracks[rand_range(0, 7)]
	$BgStream2.stop()
	$BgStream2.stream = bg_track_2
	$BgStream1.play()
