extends Weapon

class_name RangeWeapon

@export var bullet : PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass

func shoot():
	var bullet_instance = bullet.instantiate()
	get_tree().get_root().add_child(bullet_instance)
	bullet_instance.rotation = self.rotation + PI/2
	bullet_instance.global_position = self.global_position


func _unhandled_input(event):
	if event.is_action_pressed("click") :
		if canShoot && equiped :
			shoot()
		HasShot.emit()
