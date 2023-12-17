extends CharacterBody2D
@export var Speed = 300.0
var Projectile
var timing
var shoot_state = 1
func aim():
	$Guitar.look_at(get_global_mouse_position())
	if (get_global_mouse_position().x < global_position.x):
		$Funk_Player.set_flip_h(true)
		$Guitar.set_flip_v(true)
	else:
		$Funk_Player.set_flip_h(false)
		$Guitar.set_flip_v(false)

func _on_timer_timeout():
	shoot_state = 1

func shoot():
	timing = preload("res://mini_bar.tscn").instantiate()
	if has_node("../MiniBar"):
		timing = get_node("../MiniBar")
		print(timing.timing)
	if shoot_state == 1 && $Hud.timing == true && Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
		Projectile = preload("res://Weapon/Guitar/guitar_projectile.tscn").instantiate()
		get_parent().add_child(Projectile)
		Projectile.global_position = $Guitar/Position.global_position
		Projectile.set_rotation($Guitar.get_rotation())
		shoot_state = 0
	elif Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) && $Hud.timing == false:
		shoot_state = 0
		$Timer.start()
	if $Timer.is_stopped() == true && $Hud.timing == false:
		shoot_state = 1


	#GET_PARENT REND INDEPENDANT CE QUI EST INSTANTIE DE LA NODE OU IL L'EST
	
	
func move():
	var direction = Input.get_vector("left", "right", "up", "down")
	velocity = direction * Speed
	#change animation state = move
	
func animation():
	pass
	#play idle if state == idle
	
func _physics_process(delta):
	aim()
	move()
	animation()
	shoot()
	move_and_slide()

