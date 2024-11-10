extends CharacterBody2D

var speed = 100
var player_chase = false
var player = null

var health = 100
var player_in_attack_zone = false
var can_take_damage = true

func _physics_process(delta):
	deal_with_damage()
	update_health()
	
	if player_chase:
		var direction = (player.position - position).normalized()
		position += direction * speed * delta
		$AnimatedSprite2D.play("run")
		
		# Flip the sprite based on the direction of movement
		if direction.x < 0:
			$AnimatedSprite2D.flip_h = true
		else:
			$AnimatedSprite2D.flip_h = false
	else:
		$AnimatedSprite2D.play("idle")
		
	move_and_collide(Vector2(0,0))
		
		
func _on_detection_area_body_entered(body):
	player = body
	player_chase = true
	
func _on_detection_area_body_exited(_body):
	player = null
	player_chase = false
	
func enemy():
	pass
	
func _on_enemy_hitbox_body_entered(body):
	if body.has_method("player"):
		player_in_attack_zone=true

func _on_enemy_hitbox_body_exited(body):
	if body.has_method("player"):
		player_in_attack_zone=false
	
func deal_with_damage():
	if player_in_attack_zone and Global.player_current_attack==true:
		if can_take_damage == true:
			health = health - 20
			$take_damage_cooldown.start()
			can_take_damage= false
			print("enemy health = ", health)
			if health <= 0:
				Global.one_enemy_killed()
				self.queue_free()

func _on_take_damage_cooldown_timeout():
	can_take_damage = true
	
func update_health():
	var healthbar = $healthbar
	
	healthbar.value = health
	
	if health >= 100:
		healthbar.visible = false
	else:
		healthbar.visible = true


