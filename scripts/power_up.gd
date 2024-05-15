extends Area2D

signal powerup_hit(powerup_value)

@onready var power_text = $PowerText
@onready var pickup_animation = $PickupAnimation

var rng = RandomNumberGenerator.new()
# 0 = Normal ; 1 = Double Jump ; 2 = Dash
var powerup: int = rng.randi_range(0, 2)

func _on_body_entered(_body : CharacterBody2D):
	pickup_animation.play("pickup")
	print(powerup)
	match powerup:
		0:
			power_text.text = "No Power"
		1:
			power_text.text = "Double Jump"
		2:
			power_text.text = "Dash"
	powerup_hit.emit(powerup)

	
