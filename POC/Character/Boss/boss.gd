extends CharacterBody2D
@export var SPEED = 300.0
@onready var Player = get_node("../Player") #access Player
@onready var Hud = get_node("../Player/Hud") #access Player
var Projectile
var once : bool = false
var state = "static"
var change_state : bool = true

"func state_():
	while (change_state == false):
		return 0
	if (change_state == true):
		state = 
		state =
		state = 
		change_state = false

func movement():
	if (state == ):
		x_=randi()%200+50
		y_=randi()%200+50
		state 
	if (self.position == (x_, y_)):
		state =
	velocity = direction * SPEED * -1"
	
func aimbot():
	if once == true && Hud.timing == true:
		Projectile = preload("res://Weapon/Guitar/guitar_projectile.tscn").instantiate()
		get_parent().add_child(Projectile)
		Projectile.global_position = $Guitar/Position.global_position
		Projectile.set_rotation($Guitar.get_rotation())
		once = false
	if Hud.get_timing() == false:
		once = true
		
	var sin=(Player.get_position().y - global_position.y)
	var cos=(Player.get_position().x - global_position.x)
	if (Player.get_position().x > global_position.x):
		$Guitar.set_flip_v(false)
		$Guitar.set_rotation((atan(sin/cos)))
	else:
		$Guitar.set_flip_v(true)
		$Guitar.set_rotation((atan(sin/cos)+PI))

		
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	aimbot()
	"movement()"
	move_and_slide()
