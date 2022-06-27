class_name WeaponItem extends Item

export var _bullet_prefab : PackedScene
export var _shot_sound : AudioStream
var cartridges_count = 8

func getBullet():
	return _bullet_prefab
	
func getShotSound():
	return _shot_sound

