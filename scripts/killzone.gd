extends Area2D

@onready var timer = $Timer
var currentHealth: int = 3

func _on_body_entered(body):
	Engine.time_scale = 0.5
	body.get_node("CollisionShape2D").queue_free()
	timer.start()


func _on_timer_timeout():
	Engine.time_scale = 1.0
	PowerUpAutoload.double_jump = false	
	PowerUpAutoload.dash = false	
	get_tree().reload_current_scene()
	
