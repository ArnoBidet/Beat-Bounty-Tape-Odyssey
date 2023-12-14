extends Area2D

@export var speed : int = 500

func _physics_process(delta):
	global_position -= global_transform.y * speed * delta

func _on_Bullet_body_entered(body):
	body.queue_free()
	queue_free()
