tool
extends Area2D

export var _item_resource : Resource 

func _ready():
	if _item_resource:
		$Sprite.texture = _item_resource._sprite
