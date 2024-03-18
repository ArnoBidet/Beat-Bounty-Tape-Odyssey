extends CharacterBody2D
@export var Speed = 1000.0
var shoot_state : bool = 1
@onready var skin = $Funk_Player
#penser à ajouter une fonction qui change le skin

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func move():
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * Speed
	#change animation state = move
	
func aim():
	if (get_global_mouse_position().x < global_position.x):
		skin.set_flip_h(true)
	else:
		skin.set_flip_h(false)
		
func animation():
	pass
	#play idle if state == idle
	
func _physics_process(delta):
	move()
	aim()
	animation()
	move_and_slide()
