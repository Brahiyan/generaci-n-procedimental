class_name NodoBSP extends Node

const TAMAÑO_MAXIMO_HABITACION:= Vector2i(16,9)
const TAMAÑO_MINIMO_HABITACION:= Vector2i(5,4)
const TAMAÑO_MAPA:= Vector2i(70,40)


var _padre: NodoBSP
var _hijos: Array[NodoBSP]
var _posicion: Vector2i
var _tamaño: Vector2i

func _init(padre: NodoBSP= null) -> void:
	_padre = padre
	crear_particion()

func agregar_hijo(hijo:NodoBSP) ->void:
	_hijos.append(hijo)

func establecer_tamaño() -> void:
	if _padre == null:
		_tamaño = TAMAÑO_MAPA
	#se tiene que establecer un tamaño aleatorio, teniendo en cuenta los tamaños maximos
	var ancho = randi_range(TAMAÑO_MINIMO_HABITACION.x,TAMAÑO_MAXIMO_HABITACION.x)
	var ancho_final: int = clampi(ancho, TAMAÑO_MINIMO_HABITACION.x,TAMAÑO_MAXIMO_HABITACION.x)
	
	var alto:int = randi_range(TAMAÑO_MINIMO_HABITACION.x,TAMAÑO_MAXIMO_HABITACION.x)
	var alto_final:int = clampi(alto, TAMAÑO_MINIMO_HABITACION.x,TAMAÑO_MAXIMO_HABITACION.x)
	
	_tamaño = Vector2i(ancho_final,alto_final)
	print(str(self) + "tamaño " + str(_tamaño))

func obtener_tamaño() -> Vector2i:
	return _tamaño

func establecer_posicion() -> void:
	if _padre == null:
		_posicion = Vector2i(randi_range(0,TAMAÑO_MAPA.x),randi_range(0,TAMAÑO_MAPA.y))
		return
#se tiene que obtener una posicion random dentro de los margenes del tamaño del padre
	var pos_x = randi_range(_padre.obtener_posicion().x + 2 , _padre.obtener_posicion().x + _padre.obtener_tamaño().x)
	var pos_y = randi_range(_padre.obtener_posicion().y + 2 , _padre.obtener_posicion().y + _padre.obtener_tamaño().y)
	
	_posicion = Vector2i(pos_x,pos_y)
	print(str(self) + "posicion " + str(_posicion))

func obtener_posicion() -> Vector2i:
	return _posicion

func crear_hijo() -> NodoBSP: 
	var hijo = NodoBSP.new(self)
	return hijo

func crear_particion()-> void:
	#seria tomar la posicion de inicio y se le suma el tamaño que va a tener 
	#entonces se hace un for contemplado desde la posicion el tamaño en X y los mismo con Y.
	establecer_posicion()
	establecer_tamaño()
