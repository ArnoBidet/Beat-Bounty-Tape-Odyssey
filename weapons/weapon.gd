extends Node2D

class_name Weapon

@export var on_floor: bool = true
var player_near: bool = false
var body: PhysicsBody2D
var body_position : Vector2

@onready var player_detector: Area2D = get_node("player_detector")
@onready var pick_up: Sprite2D = get_node("pick_up")

var init_scale = scale

func _ready():
	pick_up.hide()

func _physics_process(_delta):
	if (not on_floor) :
		self.position=Vector2(0,0)
		look_at(get_global_mouse_position())
		self.position = Vector2(cos(deg_to_rad(global_rotation_degrees)), sin(deg_to_rad(global_rotation_degrees))) * 700
		var look = get_global_mouse_position() - global_transform.origin
		if not( global_rotation_degrees <= 90 and global_rotation_degrees >= -90):
			set_scale(Vector2(init_scale.x,-init_scale.y))
		else :
			set_scale(Vector2(init_scale.x,init_scale.y))

func _process(_delta):
	pass



func _input(event):
	if Input.is_key_pressed(KEY_E) and player_near:
		on_floor = false
		player_near = false
		pick_up.hide()
		body.pick_up_weapon(self)
			
func _on_player_detector_body_entered(_body):
	if on_floor != false :
		body = _body
		body_position = body.position
		player_near = true
		pick_up.show()
	
func _on_player_detector_body_exited(_body):
	pick_up.hide()
	player_near = false
	body = null

func get_texture() -> Texture2D:
	return get_node("weapon_outlet").texture
