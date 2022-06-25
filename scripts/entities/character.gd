class_name Character extends KinematicBody2D

export var _hp = 100
export var _max_hp = 100
export var _speed = 60
export (Fractions.FractionsList) var _fraction
export var _weapon_slot : Resource

var _type = ""
	
func _process(delta):
	if _hp <= 0:
		queue_free()
	
func addHP(value):
	_hp += value
	
func getFraction():
	return _fraction

func shot(pos):
	if _weapon_slot:
		$Ray.cast_to = Vector2( position.distance_to(pos), 0)
		var obj = $Ray.get_collider()
		
		# Logic
		if obj:
			pos = $Ray.get_collision_point()
			obj.addHP(-rand_range(10,25))
			if obj._type != "player":
				obj.setTarget(self)
		
		# Animation
		$Animation.frame = 0
		$Animation.play("shot")
		
		# Visual
		var bullet = _weapon_slot.getBullet()
		if bullet:
			bullet = bullet.instance()
			bullet.setTarget(pos)
			bullet.position = position
			get_tree().current_scene.add_child(bullet)
		
		# Sound
		var sound = _weapon_slot.getShotSound()
		if sound:
			$Audio.stream = sound
			$Audio.play()
