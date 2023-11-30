extends CharacterBody2D
@export var speed: int = 500  

var bullet = preload("res://weapons/bullet.tscn")
var canShoot = false

func shoot():
	var bullet_instance = bullet.instantiate()
	get_parent().add_child(bullet_instance)
	bullet_instance.rotation = $Weapon.rotation + PI/2

	bullet_instance.global_position = $Weapon/Muzzle.global_position

	
func Canshoot():
	canShoot = not canShoot

func _physics_process(delta):
	var note = get_node("res://hud/note.tscn")
	#note.CanShoot.connect(Canshoot)
	
	var target_position = get_global_mouse_position()
	var object_position = global_transform.origin
	var look = target_position - object_position
	if look.x <= 0:
		get_node("AnimatedSprite2D").flip_h = true
	elif look.x > 0:
		get_node("AnimatedSprite2D").flip_h = false
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * speed
	move_and_slide()
	
	
	
	if Input.is_action_just_pressed("click") and canShoot:
		shoot()
		
		


func _on_hud_can_shoot(state):
	canShoot = state
