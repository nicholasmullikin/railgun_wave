extends Camera2D

var screen_shake_start = false
var shake_intensity = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	Global.camera = self


func _exit_tree():
	Global.camera = null
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	zoom = lerp(zoom, Vector2(1, 1), 0.3)
	
	if screen_shake_start == true:
		global_position += Vector2(
			randf_range(-shake_intensity, shake_intensity),
			randf_range(-shake_intensity, shake_intensity)
		) * delta

func screen_shake(intensity, time):
	zoom = Vector2(1, 1) - Vector2(intensity * 0.0005, intensity * 0.0005)
	shake_intensity == intensity
	$Screen_shake_time.wait_time = time
	$Screen_shake_time.start()
	screen_shake_start = true

func _on_screen_shake_time_timeout():
	screen_shake_start = false
