extends Sprite2D

var speed = 75
var velocity = Vector2()
var bullet = preload("res://Bullet.tscn")
var stun = false
var hp = 1

var blood_particles = preload("res://blood_particles.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Global.player != null and stun == false:
		velocity = global_position.direction_to(Global.player.global_position)
	elif stun:
		velocity = lerp(velocity, Vector2(0, 0), 0.3)
	
	global_position += velocity * speed * delta
	if hp <= 0:
		if Global.camera != null:
			Global.camera.screen_shake(60, 0.02)
		if Global.node_creation_parent != null:
			var blood_particles_instance = Global.instantiate_node(blood_particles, global_position, Global.node_creation_parent)
			blood_particles_instance.rotation = velocity.angle()
		queue_free()
		Global.score += 1

func _on_hitbox_area_entered(area):
	if area.is_in_group("Enemy_damager") and stun == false:
		modulate = Color.WHITE
		velocity = -velocity * 6
		hp -= 1
		stun = true
		$Stun_timer.start()
		area.get_parent().health -= 1
		Global.instantiate_node(bullet, global_position, Global.node_creation_parent)
		Global.instantiate_node(bullet, global_position, Global.node_creation_parent)
		Global.instantiate_node(bullet, global_position, Global.node_creation_parent)
		# area.get_parent().queue_free()



func _on_timer_timeout():
	modulate = Color("6a0000")
	stun = false
