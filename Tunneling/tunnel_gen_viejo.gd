@tool
class_name GeneradorTunelViejo extends Node


const TILE_MAP_DATA: Dictionary ={
	"Piso": {
		"source_id": 1,
		"coord_atlas": Vector2i(2,0)
	},
	"Pared": {
		"source_id": 1,
		"coord_atlas": Vector2i(0,1)
	}
}

@export var dimensiones : Vector2i = Vector2i(50,50)
@export_tool_button("Generar Mapa") var mapa_gen = generar_mapa
@export var tile_map_layer: TileMapLayer
@export var cant_habitaciones: int = 4

var habitaciones: Array[Habitacion]

func _ready() -> void:
	rellenar_mapa()
	generar_mapa()
	ordenar_habitaciones()
	print(obtener_direccion(habitaciones[0].dimensiones.position,habitaciones[1].dimensiones.position))


func rellenar_mapa() -> void:
	for x in dimensiones.x:
		for y in dimensiones.y:
			tile_map_layer.set_cell(Vector2i(x,y),TILE_MAP_DATA.Piso.source_id, TILE_MAP_DATA.Piso.coord_atlas)

func generar_mapa() -> void:
	var iteracion : int = 0
	while iteracion < cant_habitaciones:
		var f = generar_habitación()
		if f != null: iteracion +=1

func generar_habitación()-> Habitacion:
	var pos_inicial: Vector2i = Vector2i(randi_range(0, dimensiones.x),randi_range(0, dimensiones.y))

	if habitaciones.size() == 0: pos_inicial = Vector2i(dimensiones.x * 0.5,dimensiones.y * 0.5)

	var tam_x =randi_range(4,7)
	var tam_y =randi_range(4,7)
	if corroborar_colocacion(pos_inicial,Vector2i(tam_x,tam_y)):
		for i in tam_x:
			for j in tam_y:
				tile_map_layer.set_cell(Vector2i(pos_inicial.x + i, pos_inicial.y + j)
				,TILE_MAP_DATA.Pared.source_id,
				TILE_MAP_DATA.Pared.coord_atlas)
		var nueva_hab = Habitacion.new(pos_inicial,Vector2i(tam_x, tam_y))
		nueva_hab.componer_habitacion(TILE_MAP_DATA.Pared.coord_atlas)
		habitaciones.append(nueva_hab)
		return nueva_hab
	else: return null

func corroborar_colocacion(pos: Vector2i,tamaño_h: Vector2i) -> bool:
	if habitaciones.size() == 0: return true
	var t_rect = Rect2i(pos,tamaño_h)
	var tamaño_total = pos + tamaño_h
	if tamaño_total.x > dimensiones.x or tamaño_total.y > dimensiones.y :
		print("Está por fuera del mapa")
		return false

	for h in habitaciones:
		if h.dimensiones.intersects(t_rect):
			print("contiene el punto")
			return false
	
	return true

func ordenar_habitaciones() -> void:
	habitaciones.sort_custom(func(a,b): return a.dimensiones.position < b.dimensiones.position)
	for h in habitaciones:
		print(h.dimensiones)

func obtener_direccion(pos_inicial: Vector2i, pos_final: Vector2i) -> Vector2i:
	var distancia = pos_inicial - pos_final
	return Vector2i(-signi(distancia.x), signi(distancia.y))

func elegir_lado(direccion_habitacion: Vector2i) -> void:
	pass
