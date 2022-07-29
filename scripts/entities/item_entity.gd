tool
extends ActionEntity

export var _item_resource : Resource 

func _ready():
	type = Entity.TYPE.ITEM
	_hint = "Взять (E)"
	if _item_resource:
		$Sprite.texture = _item_resource._sprite
		
func _physics_process(delta):
	linear_velocity = Vector2.ZERO
	angular_velocity = 0
	
func getResource():
	return _item_resource
	
func addDamage(value):
	pass
