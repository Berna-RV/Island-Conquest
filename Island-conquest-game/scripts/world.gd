extends Node2D

func _ready():
	$init_message_timer.start()

func _on_init_message_timer_timeout():
	$init_message.visible = false
	$init_message_timer.stop()
	
func _process(_delta):
	if Global.player_won:
		get_tree().reload_current_scene()  # This reloads the current scene
