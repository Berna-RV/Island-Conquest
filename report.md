# Concept Document - Challenge 2 - It's Mine

## Pitch Line
Take on the role of a brave knight tasked with reclaiming the king’s islands from goblin invaders in a strategic, tile-based game of combat and conquest.

## Introduction
Island Conquest is set on a series of mystical islands once ruled by a mighty king. After a goblin invasion, these lands have fallen into enemy hands. As the a knight of the king’s guard, your mission is to defeat the seven goblin leaders scattered across the islands, restoring peace and reclaiming the territory. The game combines strategic movement with simple combat mechanics, inviting players to experience a medieval-themed quest for victory.

## Demographic Breakdown

+ Target Audience: Players aged 8+, especially fans of strategy and action games.
+ Genre: Strategy/Tile-based Adventure
+ Platform: PC

## Feature List

+ Single-player campaign with NPC-controlled goblin enemies
+ Tile-based movement across island territories
+ Simple combat mechanics focused on defeating goblins (W, S, A, D for movement, and Left-Click for attack)
+ Victory condition: Defeat all goblins to reclaim the islands
+ Medieval-themed assets, including knight character and goblin sprites

## Feature List Breakdown

+ Single-Player Campaign
  + The player controls a knight who must strategically navigate through island tiles, encountering goblins to reclaim the land.
+ Tile-Based Movement
  + Movement is restricted to island tiles, encouraging strategic choices as players approach enemies and plan their attacks.
+ Simple Combat Mechanics
    The player initiates combat upon approaching goblin NPCs, with straightforward mechanics that make the game accessible yet engaging.
+ Victory Condition
  + The player wins by defeating all seven goblins, each strategically placed across the islands. Victory is achieved when all goblins are defeated, and the territory is reclaimed.
+ Medieval-Themed Assets
  + Game visuals include a knight character, goblin sprites, and island-themed tiles, all contributing to the medieval, conquest-driven atmosphere.

## Implementation Reference

This document outlines the key components of the game, including data structures and functions related to Game State, Player Actions, Game Setup, Victory Conditions, Progression of Play, and Game Views. The game is designed with a top-down perspective and focuses on territorial acquisition with destructible towers.
Game State

## Game state
The game state is represented by a combination of several elements:

+ Board (island grid): A 2D grid or TileMap representing the islands.
+ Player: Contains data on the player position, health, alive state, win state and attack state.
+ NPCs: Stores information about non-player characters, including position, health, and behavior.

## Player Actions

Players can perform the following actions, which are defined through various functions:

+ Movement: The handle_movement() function updates the player’s position based on input.
+ Attack: perform_attack() allows players to perform an attack in the specified direction, affecting NPCs if they’re within range.

Each action is validated to ensure it aligns with the current game state.

## Game Setup

The games with all the scenes in place, the inital message appear to define the players objective desappering after 5 seconds, and when the player wins (kills all the goblins) the win message appear, reloading the game after 5 seconds.

Victory can be achieved when killing all the goblins defined in the functions:
+ check_if_player_wins - global.gd
+ one_enemy_killed - global.gd
+ win - player.gd
+ check_killed_enemies - player.gd
  
The game will call win() when the victory condition is true (all the enemies are killed).

## Progression of Play

The game progresses as the player navigates the tilemap and kills the goblins, having to attack the enemies to meet this objective.

## Game Views

The game view are, the map, the player, the enviroment assets, the enemies and healthbar to all "alive" creatures.