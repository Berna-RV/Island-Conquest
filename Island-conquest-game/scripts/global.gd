extends Node

var player_current_attack = false

var player_won= false

var number_of_killed_enemies = 0
var number_of_enemies = 7

func one_enemy_killed():
	number_of_killed_enemies = number_of_killed_enemies+1

func check_if_player_wins():
	return number_of_enemies == number_of_killed_enemies
