extends CanvasGroup
var Bpm : int = 120
var note
var timing : bool = false

func get_timing():
	return timing

func set_timing(_timing):
	timing = _timing
	
func _process(delta):
	$Timer.wait_time = 1
	
func _on_timer_timeout():	
	note = preload("res://mini_bar.tscn").instantiate()
	add_child(note)
	note.position = $spawn.get_position()
