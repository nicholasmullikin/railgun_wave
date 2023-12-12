extends Node

var node_creation_parent = null
var player = null
var score = 0
var camera = null


func instantiate_node(node, location, parent):
	var node_instance = node.instantiate()
	parent.add_child(node_instance)
	node_instance.global_position = location 
	return node_instance 
