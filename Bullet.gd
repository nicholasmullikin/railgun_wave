extends Sprite2D


var velocity = Vector2(1, 0)
var speed = 500

var look_once = true
var health = 5

func _process(delta):
	if look_once:
		look_at(get_global_mouse_position())
		look_once = false
	global_position += velocity.rotated(rotation) * speed * delta
	speed *= 1.1
	if health <= 0:
		queue_free()


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()


