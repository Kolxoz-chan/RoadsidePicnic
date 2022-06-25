class_name Stalker extends Character

var _target = null
var _gunpoint = null

export(float, 0.0, 1.0) var _stay_radius = 0.6
export(float, 0.0, 1.0) var _retreat_radius = 0.4
	
func _ready():
	_type = "npc"
	$ShotTimer.wait_time = rand_range(0.1, 2.0)
	
func _process(delta):
	var vec = Vector2(0, 0)
	
	if _target:
		if is_instance_valid(_target):
			look_at(_target.position)
			var radius = $VisionArea/Vision.shape.radius
			var distance = _target.position.distance_to(position) / radius
			
			if distance < -_retreat_radius:
				vec = position.direction_to(_target.position)
			elif distance < _stay_radius:
				vec = Vector2(0, 0)
			else:
				vec = position.direction_to(_target.position)
			
		else:
			_target = null
			
	if _gunpoint:
		vec = _gunpoint
		_gunpoint = null
	
	move_and_slide(vec * _speed)
			
func at_gunpoint(pos):
	if _target:
		_gunpoint = -position.direction_to(pos)

func setTarget(obj):
	_target = obj

func _on_VisionArea_body_entered(body):
	if body.getFraction() != self.getFraction():
		_target = body


func _on_ShotTimer_timeout():
	if _target:
		var x = rand_range(-100, 100)
		var y = rand_range(-100, 100)
		shot(_target.position + Vector2(x, y))
		$ShotTimer.wait_time = rand_range(0.1, 2.0)


func _on_Animation_animation_finished():
	$Animation.stop()
