extends Control

var _items_list
var _use_button
var _drop_button

func _ready():
	_items_list = $centered/hbox/vbox/items_panel/items_list
	_use_button = $centered/hbox/vbox/hbox/use_button
	_drop_button = $centered/hbox/vbox/hbox/drop_button
	
func addItem(item):
	_items_list.add_icon_item(item.getIcon())
	
func setCurrentItem(item):
	_use_button.visible = item.isUsable()
	_drop_button.visible = item.isDropable()
