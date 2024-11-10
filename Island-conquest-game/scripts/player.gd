extends CharacterBody2D

var enemy_in_attack_range = false
var enemy_attack_cooldown = true
var health = 200
var player_alive = true

const speed = 200
var current_dir = "none"
var previous_dir = "right"

var initial_position = Vector2()
var last_direction := Vector2(1, 0)  # Default to facing right

var attack_ip = true

var has_won = false  # Add this flag at the top

func win():
	if not has_won:
		has_won = true
		$Camera2D/win_message.visible = true
		$win_message_timer.start()
		#print("win timer started")

func check_killed_enemies():
	if Global.check_if_player_wins() and not has_won:
		win()
	
func _ready():
	# Store the player's initial position at the start
	# Reset necessary variables
	initial_position = position
	health = 200
	player_alive = true
	attack_ip = true
	has_won = false
	$AnimatedSprite2D.play("idle")
	$Camera2D/win_message.visible = false

func _physics_process(delta):
	if player_alive:
		check_killed_enemies()
		handle_movement(delta)
		enemy_attack()
		handle_attack_input()
		update_health()
	
	if health <= 0 and player_alive:
		player_alive = false
		health = 0
		$AnimatedSprite2D.play("dead")
		await get_tree().create_timer(1.7).timeout  # Adjust timing to match animation length
		print("Player has been killed")
		_respawn_player()

func _respawn_player():
	# Respawn logic (position reset, health update, animation)
	position = initial_position
	health = 200
	player_alive = true
	#get_tree().reload_current_scene()  # This reloads the current scene
	$AnimatedSprite2D.play("idle")
	print("Player has respawned")
	
func handle_movement(_delta):
	# Only handle movement if not attacking
	if attack_ip:
		# Get input for movement
		var direction := Vector2(
			Input.get_action_strength("run_right") - Input.get_action_strength("run_left"),
			Input.get_action_strength("run_down") - Input.get_action_strength("run_up")
		).normalized()

		# Set velocity based on input direction and speed
		velocity = direction * speed

		# Use move_and_slide without arguments to handle movement and respect collisions
		move_and_slide()

		# Update last movement direction if moving
		if direction != Vector2.ZERO:
			last_direction = direction
			$AnimatedSprite2D.play("run")  # Play the running animation

			# Flip sprite horizontally based on left/right movement
			$AnimatedSprite2D.flip_h = last_direction.x < 0
		else:
			$AnimatedSprite2D.play("idle")  # Play idle animation when not moving
	
func handle_attack_input():
	# Check for attack input (single button, e.g., left mouse click or space bar)
	if Input.is_action_just_pressed("attack") and attack_ip:
		Global.player_current_attack = true
		perform_attack(last_direction)
		
func perform_attack(direction: Vector2):
	# Prevent movement and play attack animation based on direction
	attack_ip = false  # Disable further attacks
	velocity = Vector2.ZERO  # Stop movement to prevent animation conflicts

	# Play the appropriate attack animation based on direction
	if direction == Vector2(0, -1):
		$AnimatedSprite2D.play("back_attack")
		print("Attacking Up")
		$deal_attack_timer.start()
	elif direction == Vector2(0, 1):
		$AnimatedSprite2D.play("front_attack")
		print("Attacking Down")
		$deal_attack_timer.start()
	elif direction == Vector2(-1, 0):
		$AnimatedSprite2D.play("side_attack")
		print("Attacking Left")
		$deal_attack_timer.start()
	elif direction == Vector2(1, 0):
		$AnimatedSprite2D.play("side_attack")
		print("Attacking Right")
		$deal_attack_timer.start()
	else:
		$AnimatedSprite2D.play("idle")  # Default to idle attack if stationary
		print("Attacking Idle")
	
func player():
	pass

func _on_player_hitbox_body_entered(body):
	if body.has_method("enemy"):
		enemy_in_attack_range=true

func _on_player_hitbox_body_exited(body):
	if body.has_method("enemy"):
		enemy_in_attack_range=false
		
func enemy_attack():
	if enemy_in_attack_range and enemy_attack_cooldown:
		health = health - 20
		enemy_attack_cooldown = false
		$attack_cooldown.start()
		print(health)
	
func _on_attack_cooldown_timeout():
	enemy_attack_cooldown = true

func _on_deal_attack_timer_timeout():
	$deal_attack_timer.stop()
	Global.player_current_attack = false
	attack_ip = true
	
func update_health():
	var healthbar = $healthbar
	healthbar.value = health
	if health >= 200:
		healthbar.visible = false
	else:
		healthbar.visible = true

func _on_regin_timer_timeout():
	if health < 200:
		health = health + 20
		if health > 200:
			health = 200
	if health <= 0:
		health = 0

func _on_win_message_timer_timeout():
	print("player won")
	$Camera2D/win_message.visible = false
	$win_message_timer.stop()
	Global.player_won = true
	_respawn_player()
