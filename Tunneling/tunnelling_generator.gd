class_name GeneradorTunel extends Node
#TAMAÑO MAPA 71 x 40

const TILE_MAP_DATA: Dictionary ={
	"Piso": {
		"source_id": 1,
		"coord_atlas": Vector2i(2,0)
	},
	"Pared": {
		"source_id": 1,
		"coord_atlas": Vector2i(19,0)
	}
}

@export var dimensiones : Vector2i = Vector2i(50,50)
@export var tile_map_layer: TileMapLayer
@export var cant_habitaciones: int = 4

var habitaciones: Array[Habitacion]
var celdas_usadas: Array

func _ready() -> void:
	#rellenar_mapa()
	crear_primer_habitacion()
	generar_mapa()
	generar_mapa()
	celdas_usadas = tile_map_layer.get_used_cells()
	#tile_map_layer.set_cells_terrain_connect(celdas_usadas,0,0)


func rellenar_mapa() -> void:
	for x in dimensiones.x:
		for y in dimensiones.y:
			tile_map_layer.set_cell(Vector2i(x,y),TILE_MAP_DATA.Piso.source_id, TILE_MAP_DATA.Piso.coord_atlas)

func generar_mapa() -> void:
	var contador_break: int = 0
	var iteracion : int = 0
	while iteracion < cant_habitaciones:
		var f = generar_habitación()
		if f == Habitacion:
			iteracion +=1
			contador_break = 0
		elif f == null: 
			contador_break +=1
		
		if contador_break == 50: 
			print("se salio de generador de mapa")
			return

func generar_habitación()-> Habitacion:
	var pos_inicial: Vector2i
	var direccion_pared: Vector2i
	
	var data_habitacion: Dictionary = elegir_lado_habitacion(habitaciones[habitaciones.size()-1])
	#var data_habitacion: Dictionary = elegir_lado_habitacion(habitaciones.pick_random())
	
	
	direccion_pared = data_habitacion.get("direccion")
	pos_inicial = data_habitacion.get("posicion")
	var tam_x = randi_range(2,10)
	var tam_y = randi_range(2,10)
	pos_inicial = establecer_origen(pos_inicial, Vector2i(tam_x,tam_y), direccion_pared)
	
	if corroborar_colocacion(pos_inicial,Vector2i(tam_x,tam_y)):
		for x in tam_x:
			for y in tam_y:
				tile_map_layer.set_cell(Vector2i(pos_inicial.x + x, pos_inicial.y + y),TILE_MAP_DATA.Pared.source_id,TILE_MAP_DATA.Pared.coord_atlas)

		var nueva_hab = Habitacion.new(pos_inicial,Vector2i(tam_x, tam_y))
		nueva_hab.componer_habitacion(TILE_MAP_DATA.Pared.coord_atlas)
		nueva_hab.setear_paredes()
		habitaciones.append(nueva_hab)
		return nueva_hab
	else: return null

func crear_primer_habitacion() -> void:
	var tam_habitacion: Vector2i = Vector2i(5,5)
	var pos_inicial: Vector2i = Vector2i(dimensiones.x * 0.5,dimensiones.y * 0.5)
	
	for i in tam_habitacion.x:
		for j in tam_habitacion.y:
				tile_map_layer.set_cell(Vector2i((pos_inicial.x + i), pos_inicial.y + j)
				,TILE_MAP_DATA.Pared.source_id,
				TILE_MAP_DATA.Pared.coord_atlas)
	var nueva_hab = Habitacion.new(pos_inicial, tam_habitacion)
	nueva_hab.componer_habitacion(TILE_MAP_DATA.Pared.coord_atlas)
	nueva_hab.setear_paredes()
	habitaciones.append(nueva_hab)

func corroborar_colocacion(pos: Vector2i,tamaño_h: Vector2i) -> bool:
	if habitaciones.size() == 0: return true
	var t_rect = Rect2i(pos,tamaño_h)
	var tamaño_total = pos + tamaño_h
	if tamaño_total.x > dimensiones.x or tamaño_total.x < 0 or tamaño_total.y > dimensiones.y or tamaño_total.y < 0:
		print("Está por fuera del mapa")
		return false

	for h in habitaciones:
		if h.dimensiones.intersects(t_rect):
			print("contiene el punto")
			return false
	
	return true

func elegir_lado_habitacion(habitacion: Habitacion) -> Dictionary:
	var pos_pared = habitacion.dict_paredes.keys().pick_random()
	var direccion = habitacion.dict_paredes.get(pos_pared)
	var pos_dir: Dictionary = {"posicion" : pos_pared, "direccion" :direccion}
	print(pos_dir)
	return pos_dir

func establecer_origen(pos:Vector2i, tam: Vector2i, dir: Vector2i) -> Vector2i: 
	match dir:
		Vector2i.UP:
			return Vector2i(pos.x,pos.y -tam.y)
		Vector2i.RIGHT:
			return Vector2i(pos.x, pos.y)
		Vector2i.DOWN:
			return Vector2i(pos.x,pos.y)
		Vector2i.LEFT:
			return Vector2i(pos.x - tam.x, pos.y)
		_: return Vector2i.ZERO

func obtener_direccion(pos_inicial: Vector2i, pos_final: Vector2i) -> Vector2i:
	var distancia = pos_inicial - pos_final
	return Vector2i(-signi(distancia.x), signi(distancia.y))
