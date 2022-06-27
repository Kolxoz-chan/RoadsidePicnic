class_name Character extends KinematicBody2D

export var _hp = 100
export var _max_hp = 100
export var _speed = 60
export (Fractions.FractionsList) var _fraction
export var _damage_sound : AudioStream

# Slots
export var _weapon_slot : Resource

# Entity settings
var type = Entity.TYPE.CHARACTER

signal health_changed()
	
func _process(delta):
	if _hp <= 0:
		queue_free()
	
func addHP(value):
	_hp += value
	emit_signal("health_changed")
	
func addDamage(value):
	addHP(-value)
	if _damage_sound:
		$Audio.stream = _damage_sound
		$Audio.play()
	
	
func getFraction():
	return _fraction

func shot(pos):
	if _weapon_slot:
		
		# Animation
		$Animation.frame = 0
		$Animation.play("shot")
		
		# Visual
		var bullet = _weapon_slot.getBullet()
		if bullet:
			bullet = bullet.instance()
			bullet.setOwner(self)
			bullet.setTarget(pos)
			bullet.position = position
			get_tree().current_scene.add_child(bullet)
		
		# Sound
		var sound = _weapon_slot.getShotSound()
		if sound:
			$Audio.stream = sound
			$Audio.play()
