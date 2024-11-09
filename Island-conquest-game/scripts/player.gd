extends CharacterBody2D

const speed = 200
var current_dir = "none"
var previous_dir = "right"

func _ready():
	$AnimatedSprite2D.play("idle")
	
func _physics_process(delta):
	player_movement(delta)
	
func player_movement(delta):
	if Input.is_action_pressed("run_right"):
		current_dir = "right"
		play_anim(1)
		velocity.x = speed
		velocity.y = 0
	elif Input.is_action_pressed("run_left"):
		current_dir = "left"
		play_anim(1)
		velocity.x = -speed
		velocity.y = 0
	elif Input.is_action_pressed("run_down"):
		current_dir = "down"
		play_anim(1)
		velocity.y = speed
		velocity.x = 0
	elif Input.is_action_pressed("run_up"):
		current_dir = "up"
		play_anim(1)
		velocity.y = -speed
		velocity.x = 0
	else:
		play_anim(0)
		velocity.x=0
		velocity.y=0
		
	move_and_slide()
	
func play_anim(movement):
	var dir = current_dir
	var anim = $AnimatedSprite2D
	
	if dir == "right":
		previous_dir= "right"
		anim.flip_h = false
		if movement == 1:
			anim.play("run")
		if movement == 0:
			anim.play("idle")
	elif dir == "left":
		previous_dir = "left"
		anim.flip_h = true
		if movement == 1:
			anim.play("run")
		if movement == 0:
			anim.play("idle")
	elif dir == "down":
		if previous_dir == "right":
			anim.flip_h = false
			if movement == 1:
				anim.play("run")
			if movement == 0:
				anim.play("idle")
		else: # previous dir is equal to left
			anim.flip_h = true
			if movement == 1:
				anim.play("run")
			if movement == 0:
				anim.play("idle")
	elif dir == "up":
		if previous_dir == "right":
			anim.flip_h = false
			if movement == 1:
				anim.play("run")
			if movement == 0:
				anim.play("idle")
		else: # previous dir is equal to left
			anim.flip_h = true
			if movement == 1:
				anim.play("run")
			if movement == 0:
				anim.play("idle")
	
