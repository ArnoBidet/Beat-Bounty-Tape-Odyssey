extends CanvasLayer
signal CanShoot()
var n = 0
var group_note = []

func _process(_delta):
	if( n%50 == 0):
		var note1 = preload("res://hud/note.tscn").instantiate()
		add_child(note1)
		group_note.push_front(note1)
	n+=1
	

func _on_player_has_shot():
	if group_note != null and group_note.size() > 0 :
		group_note[group_note.size()-1].queue_free()
		group_note.remove_at(group_note.size()-1)


func _on_note_end_trail_area_entered(area):
	if group_note != null and group_note.size() > 0 :
		group_note[group_note.size()-1].queue_free()
		group_note.remove_at(group_note.size()-1)
