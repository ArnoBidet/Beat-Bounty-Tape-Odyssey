extends CanvasLayer
class_name HUD
signal CanShoot(bool)
var n = 0
var group_note = []

func _process(_delta):
	if( n%50 == 0):
		var note1 = preload("res://hud/note.tscn").instantiate()
		add_child(note1)
		group_note.push_front(note1)
	n+=1
	

func _on_weapon_has_shot():
	removeLast()

func removeLast():
	if group_note != null and group_note.size() > 0 :
		group_note[group_note.size()-1].queue_free()
		group_note.remove_at(group_note.size()-1)


func _on_note_strike_zone_area_entered(_area):
	CanShoot.emit(true)


func _on_note_strike_zone_area_exited(_area):
	CanShoot.emit(false)
	removeLast()
