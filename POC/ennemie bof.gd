extends CharacterBody2D
var bullet = preload("res://bullet_ennemy.tscn")
var shoot_on = true
var n=0
	
func shoot():
	var bullet_instance = bullet.instantiate()
	get_parent().add_child(bullet_instance)
	
	bullet_instance.global_position = global_position
	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if shoot_on == true:
		if (n ==50):
			n=0
			shoot()	
		n+=1
		

	else:
		pass



func _on_area_2d_body_entered(body):
	if body.name == "body":
		shoot_on = true


func _on_area_2d_body_exited(body):
	shoot_on = false
