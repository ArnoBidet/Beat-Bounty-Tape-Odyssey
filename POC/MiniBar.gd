extends Sprite2D

@onready var Hud = get_node("..") #access Player
func _ready():
	pass # Replace with function body.

func _process(delta):
	position.x -= 600 * delta # make it move to the left
	
func _on_hitbox_area_exited(area):
	if area.name == "Rythm": #if it leaves the rythm intervall
		Hud.set_timing(false)
		queue_free() #it destroys itself

func _on_hitbox_area_entered(area):
	if area.name == "Rythm":
		Hud.set_timing(true)
