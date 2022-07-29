class_name Player extends Character

var pause = false
var _velocity : Vector2
var _gunpoint : Vector2
export var _speed_boost = 2
	
func _ready():
	type = Entity.TYPE.PLAYER
	rotation_degrees = 0
	
	$ui/hud_screen/hbox/stats/vbox/hbox/hp_bar.value = _hp
	$ui/hud_screen/hbox/stats/vbox/hbox/hp_bar.max_value = _max_hp
	$ui/hud_screen/hbox/weapon/CenterContainer/weapon_icon.texture = _weapon_slot._icon
	$ui/hud_screen/hint_panel.visible = false
	$ui/hud_screen.visible = true
	
	
	for obj in _inventory:
		$ui/inventory_screen.addItem(obj)
	
func _input(event):
	if !pause:
		if event is InputEventMouseButton:
			if event.button_index == 1 and event.pressed:
				var pos = get_global_mouse_position()
				shot(pos)
	
	
	
func motion_controll():
	var speed = _speed
	var vec = Vector2.ZERO
	
	if Input.is_action_just_pressed("ui_inventory"):
		$ui/inventory_screen.visible = !$ui/inventory_screen.visible
		pause = !pause
	if Input.is_action_pressed("ui_boost"):
		speed *= _speed_boost
	if Input.is_action_pressed("ui_right"):
		vec.x = 1
	if Input.is_action_pressed("ui_left"):
		vec.x = -1
	if Input.is_action_pressed("ui_up"):
		vec.y = -1
	if Input.is_action_pressed("ui_down"):
		vec.y = 1
		
	_velocity = vec * speed


func rotation_controll():
	_gunpoint = get_global_mouse_position()
	$ui/hud_screen/hint_panel.visible = false
	
	$Ray.cast_to = _gunpoint - position 
	if $Ray.is_colliding():
		var obj = $Ray.get_collider()
		var point = $Ray.get_collision_point()
		
		if obj.type == Entity.TYPE.CHARACTER:
			obj.at_gunpoint(point)
		elif obj.type == Entity.TYPE.ITEM:
			if position.distance_to(point) < 40:
				$ui/hud_screen/hint_panel.visible = true
				$ui/hud_screen/hint_panel/CenterContainer/action_hint.text = obj.getHint()
				
				if Input.is_action_just_pressed("ui_take"):
					var item = obj.getResource()
					addItem(item)
					$ui/inventory_screen.addItem(item)
					obj.queue_free()
		
func _process(delta):
	motion_controll()
	rotation_controll()
	
	if !pause:
		$Animation.look_at(_gunpoint)
		move_and_slide(_velocity)
		
		_velocity = Vector2.ZERO

func _on_Animation_animation_finished():
	$Animation.stop()

func _on_player_health_changed():
	$ui/hud_screen/hbox/stats/vbox/hbox/hp_bar.value = _hp
