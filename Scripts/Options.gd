extends Control

func _ready():
	$MasterSlider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	$MusicSlider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("BgMusic"))
	$SfxSlider.value = AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Sfx"))


func _on_MasterSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), $MasterSlider.value)


func _on_MusicSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("BgMusic"), $MusicSlider.value)


func _on_SfxSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Sfx"), $SfxSlider.value)
