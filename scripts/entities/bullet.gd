class_name Bullet extends Sprite

var _target = Vector2(0, 0)
var _speed = 1500

func setTarget(vec):
	_target = vec
	
func _process(delta):
	var vec = position.direction_to(_target)
	var speed = _speed * delta
	
	look_at(_target)
	
	if position == _target:
		queue_free()
	
	if position.distance_to(_target) > speed:
		position += vec * speed
	else:
		position = _target
	
