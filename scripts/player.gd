extends CharacterBody2D


const SPEED = 130.0
const JUMP_VELOCITY = -300.0

var jump_max = 2
var jump_count = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D



func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump and recover Double Jump.
	if is_on_floor() and jump_count != 0:
		jump_count = 0
		
	if PowerUpAutoload.double_jump == true:	
		if jump_count < jump_max:
			if Input.is_action_just_pressed("jump"):
				velocity.y = JUMP_VELOCITY
				jump_count += 1
		pass
	else:
		if Input.is_action_just_pressed("jump") and jump_count < jump_max:
			velocity.y = JUMP_VELOCITY
			jump_count = 2		

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	#Flip Sprite
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction < 0:
		animated_sprite.flip_h = true
		
	#Play Animation
	if is_on_floor():
		if direction == 0:
			animated_sprite.play("idle")
		else:
			animated_sprite.play("run")
	else:
		animated_sprite.play("jump")
	
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()


func _on_power_up_powerup_hit(powerup_value:int):
	match powerup_value:
		0:
			PowerUpAutoload.double_jump = false
			PowerUpAutoload.dash = false
		1:
			PowerUpAutoload.double_jump = true
			PowerUpAutoload.dash = false
		2: 
			PowerUpAutoload.double_jump = false
			PowerUpAutoload.dash = true
	pass # Replace with function body.
