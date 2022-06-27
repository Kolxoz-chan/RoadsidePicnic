tool
class_name StaticEntity extends StaticBody2D

export var _damage_sound : AudioStream
export var _collision_shape : Shape2D
export var _sprite : Texture

var type = Entity.TYPE.DECORATION

func _ready():
	if _collision_shape:
		$CollisionShape2D.shape = _collision_shape
	if _sprite:
		$Sprite.texture = _sprite
		
	
	
func addDamage(value):
	if _damage_sound:
		$Audio.stream = _damage_sound
		$Audio.play()


func _on_static_item_rect_changed():
	update()
