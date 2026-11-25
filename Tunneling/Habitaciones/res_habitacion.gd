class_name Habitacion extends Resource

@export var dimensiones: Rect2i


var comp_habitacion: Dictionary 
var paredes: Array
var dict_paredes: Dictionary

func _init(pos: Vector2i, dim: Vector2i) -> void:
	dimensiones.position = pos
	dimensiones.size = dim
	dimensiones.end = dimensiones.position + dimensiones.size

func componer_habitacion(tile: Vector2i)-> void:
	for x in dimensiones.size.x:
		for y in dimensiones.size.y:
			comp_habitacion.set(Vector2i(dimensiones.position.x + x,
			dimensiones.position.y+ y),tile)


func setear_paredes() -> void:
	for y in range(dimensiones.position.y + 1 ,dimensiones.position.y + dimensiones.size.y):
		paredes.append(Vector2i(dimensiones.position.x, y))
		dict_paredes.set(Vector2i(dimensiones.position.x, y), Vector2i.LEFT)

	for x in range(dimensiones.position.x,dimensiones.position.x + dimensiones.size.x):
		paredes.append(Vector2i(x, dimensiones.position.y))
		dict_paredes.set(Vector2i(x, dimensiones.position.y), Vector2i.UP)
	
	for y in range(dimensiones.position.y + 1 ,dimensiones.position.y + dimensiones.size.y):
		paredes.append(Vector2i(dimensiones.position.x + (dimensiones.size.x -1 ),y))
		dict_paredes.set(Vector2i(dimensiones.position.x + (dimensiones.size.x -1 ),y), Vector2i.RIGHT)
	
	for x in range(dimensiones.position.x + 1 ,dimensiones.position.x + (dimensiones.size.x-1)):
		paredes.append(Vector2i(x, dimensiones.position.y + (dimensiones.size.y -1 )))
		dict_paredes.set(Vector2i(x, dimensiones.position.y + (dimensiones.size.y -1 )), Vector2i.DOWN)
