extends CharacterBody2D
@export var Speed = 1500.0
var shoot_state : bool = 1
@onready var skin = $Funk_Player
#penser à ajouter une fonction qui change le skin

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func move():
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	velocity = direction * Speed
	roll()
	run()
	#a ajouter change animation state = move
	
func roll():
	#add delay
	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if Input.is_action_pressed("ui_space"):
		position = position + direction * 80
	
func run():
	if Input.is_action_pressed("ui_shift"): #touche pressée relié au controle de godot modifiable
		Speed = 4000
	else:
		Speed = 1500.0
		
func aim():
	if (get_global_mouse_position().x < global_position.x):
		skin.set_flip_h(true)
	else:
		skin.set_flip_h(false)
		
func animation():
	pass
	#play idle if state == idle
	#play move if state == move etc
	
func _physics_process(delta):
	move()
	aim()
	animation()
	move_and_slide()
