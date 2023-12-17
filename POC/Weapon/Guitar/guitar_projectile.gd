extends Area2D
@export var Speed : int = 800
var direction : Vector2
var velocity : Vector2

func _ready():
	pass # Replace with function body.

func _process(delta):
	#here i mimic a move_and_slide
	direction = Vector2(cos(global_rotation),sin(global_rotation)).normalized() # follow the direction he's in it
	velocity = direction * Speed #add velocity towards direction
	position += velocity * delta #make it move by velocity times delta

#Détruire le projectile quand il touche et changer variable vie
func _on_body_entered(body):
	queue_free()
