extends Node2D

var enemy_1 = preload("res://Enemy.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.node_creation_parent = self


func _exit_tree():
	Global.node_creation_parent = null


func _on_enemy_spawn_timer_timeout():
	
	var enemy_position = Vector2(randi_range(-160, 670), randi_range(-100, 400))
	 
	while (Global.player != null and Global.player.global_position.distance_to(enemy_position) < 300):
		enemy_position = Vector2(randi_range(-160, 670), randi_range(-100, 400))
	
	Global.instantiate_node(enemy_1, enemy_position, self)
