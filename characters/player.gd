extends CharacterBody2D

signal weapon_switched(prev_index, new_index)
signal weapon_picked_up(weapon_texture)
signal weapon_droped(index)
signal HasShot()
@export var speed: int = 500  

var bullet = preload("res://weapons/bullet.tscn")
var canShoot = false

var weapon_inventory = []
var equipped_weapon_index: int = 0
var current_weapon: Node2D
@onready var weapons: Node2D = get_node("Weapons")

func _ready() -> void:
	if weapons.get_child(0) != null:
		emit_signal("weapon_picked_up", weapons.get_child(0).get_texture())


func shoot():
	var bullet_instance = bullet.instantiate()
	get_parent().add_child(bullet_instance)
	bullet_instance.rotation = $Weapon.rotation + PI/2

	bullet_instance.global_position = $Weapon/Muzzle.global_position


func Canshoot():
	canShoot = not canShoot

func _physics_process(_delta):
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
	#if current_weapon != null:
		#print(current_weapon.position)


func _unhandled_input(event):
	if event.is_action_pressed("click") :
		if canShoot :
			shoot()
		HasShot.emit()
	if event is InputEventMouseButton :
		var emb : InputEventMouseButton = event
		if emb.is_pressed() :
			if emb.button_index == MOUSE_BUTTON_WHEEL_UP:
				switch_weapon(MOUSE_BUTTON_WHEEL_UP)
			if emb.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				switch_weapon(MOUSE_BUTTON_WHEEL_DOWN)
			
		


func _on_hud_can_shoot(state):
	canShoot = state

# WEAPON RELATED
func switch_weapon(direction: int) -> void:
	if current_weapon == null : return
	var prev_index: int = current_weapon.get_index()
	var index: int = prev_index
	if direction == MOUSE_BUTTON_WHEEL_UP:
		index -= 1
		if index < 0:
			index = weapons.get_child_count() - 1
	else:
		index += 1
		if index > weapons.get_child_count() - 1:
			index = 0

	current_weapon.hide()
	current_weapon = weapons.get_child(index)
	current_weapon.show()

	emit_signal("weapon_switched", prev_index, index)

func pick_up_weapon(weapon: Node2D) -> void:
	weapon_inventory.append(weapon.duplicate())
	var new_index: int = weapons.get_child_count()
	weapon.get_parent().call_deferred("remove_child", weapon)
	weapons.call_deferred("add_child", weapon)
	weapon.set_deferred("owner", weapons)
	weapon.set_deferred("position", Vector2(0,0))
	weapon.set_deferred("offset", Vector2(250,0))
	weapon.set_deferred("z_index", 200)
	weapon.get_node("weapon_outlet").set_deferred("scale",Vector2(2,2))
	
	

	if current_weapon != null:
		current_weapon.hide()
		# current_weapon.cancel_attack()
	current_weapon = weapon

	emit_signal("weapon_picked_up", weapon.get_texture())
	emit_signal("weapon_switched", equipped_weapon_index, new_index)
	

func _drop_weapon() -> void:
	weapon_inventory.remove_at(current_weapon.get_index() - 1)
	var weapon_to_drop: Node2D = current_weapon
	switch_weapon(MOUSE_BUTTON_WHEEL_DOWN)

	emit_signal("weapon_droped", weapon_to_drop.get_index())

	weapons.call_deferred("remove_child", weapon_to_drop)
	get_parent().call_deferred("add_child", weapon_to_drop)
	weapon_to_drop.set_owner(get_parent())
	await weapon_to_drop.tree_entered
	weapon_to_drop.show()

	var throw_dir: Vector2 = (get_global_mouse_position() - position).normalized()
	weapon_to_drop.interpolate_pos(position, position + throw_dir * 50)
