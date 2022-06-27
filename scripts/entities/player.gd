class_name Player extends Character

export var _speed_boost = 2
	
func _ready():
	type = Entity.TYPE.PLAYER
	$hud_screen/hbox/stats/vbox/hbox/hp_bar.value = _hp
	$hud_screen/hbox/stats/vbox/hbox/hp_bar.max_value = _max_hp
	$hud_screen/hbox/weapon/CenterContainer/weapon_icon.texture = _weapon_slot._icon
	rotation_degrees = 0
	
func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 and event.pressed:
			var pos = get_global_mouse_position()
			shot(pos)
	
func motion_controll():
	var vec = Vector2(0, 0)
	var speed = _speed
	
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
		
	move_and_slide(vec * speed)

func rotation_controll():
	var pos = get_global_mouse_position()
	$Animation.look_at(pos)
	
	$Ray.cast_to = pos - position 
	if $Ray.is_colliding():
		var obj = $Ray.get_collider()
		var point = $Ray.get_collision_point()
		
		if obj.type == Entity.TYPE.CHARACTER:
			obj.at_gunpoint(point)

func _process(delta):
	motion_controll()
	rotation_controll()

func _on_Animation_animation_finished():
	$Animation.stop()

func _on_player_health_changed():
	$hud_screen/hbox/stats/vbox/hbox/hp_bar.value = _hp
