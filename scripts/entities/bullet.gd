extends Area2D

var _owner = null
var _target = Vector2(0, 0)
var _speed = 1500

func setTarget(vec):
	_target = vec
	
func setOwner(obj):
	_owner = obj
	
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

func _on_Bullet_body_entered(body):
	if _owner != body and body.type != Entity.TYPE.ITEM:
		queue_free() 
		body.addDamage(rand_range(10, 25))
		if body.type == Entity.TYPE.CHARACTER:
			body.setTarget(_owner)
