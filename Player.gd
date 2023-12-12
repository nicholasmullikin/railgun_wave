extends Sprite2D


var speed = 250
var velocity = Vector2()

var bullet = preload("res://Bullet.tscn")
var can_shoot = true
var health = 100
var is_dead = false

func _ready():
	Global.player = self

func _exit_tree():
	Global.player = null

func _process(delta):
	var input = Input.get_vector("move_left", "move_right", "move_up", "move_down").normalized()
	global_position.x = clamp(global_position.x, 12, 628)
	global_position.y = clamp(global_position.y, 12, 348)
	if is_dead == false:
		global_position += speed * input * delta
	
	if Input.is_action_pressed("click") and Global.node_creation_parent != null and can_shoot \
	and is_dead == false:
		Global.instantiate_node(bullet, global_position, Global.node_creation_parent)
		$Timer.start()
		can_shoot = false


func _on_timer_timeout():
	can_shoot = true


   
func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


func _on_hitbox_area_entered(area):
	if area.is_in_group("Enemy"):
		is_dead = true
		visible = false
		Global.score = 0
		await(get_tree().create_timer(1).timeout)
		get_tree().reload_current_scene()
	
