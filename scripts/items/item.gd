class_name Item extends Resource

export var _name : String
export var _description : String
export var _icon : Texture
export var _sprite : Texture
export var _usable = false
export var _dropable = true

func getIcon():
	return _icon
	
func isUsable():
	return _usable
	
func isDropable():
	return _dropable
	
func onDrop(who):
	pass
	
func onUse(who):
	pass


