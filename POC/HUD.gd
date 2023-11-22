extends CanvasLayer
signal CanShoot()
var n = 0

func _process(delta):
	if( n%50 == 0):
		var note1 = preload("res://note.tscn").instantiate()
		add_child(note1)
	n+=1
	


func _on_area_2d_area_exited(area):
	CanShoot.emit(false)
	area.queue_free()


func _on_area_2d_area_entered(area):
	CanShoot.emit(true)
