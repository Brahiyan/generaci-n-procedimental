extends Camera2D

func _input(event):
# Determinar si es un evento de botón del ratón
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_WHEEL_UP:
			if event.pressed:
				zoom += Vector2(0.5,0.5) 
				zoom.x = clampf(zoom.x,0,3)
				zoom.y = clampf(zoom.y,0,3)
				
		elif event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
			if event.pressed:
				zoom -= Vector2(0.5,0.5)
				zoom.x = clampf(zoom.x,0,3)
				zoom.y = clampf(zoom.y,0,3)
				print(zoom)
