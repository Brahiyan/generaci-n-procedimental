class_name BSPTree extends Node




@onready var tm_paredes: TileMapLayer = $"../TMParedes"

@onready var nodo_raiz: NodoBSP = NodoBSP.new()

func _ready() -> void:
	crear_arbol(2)
	colocar_tiles()


func colocar_tiles() -> void:
	for i in nodo_raiz._hijos:
		for j in i._hijos:
			for k in range(j.obtener_tamaño().x):
				tm_paredes.set_cell(Vector2i(k,j.obtener_posicion().y),1,Vector2(8,5))
				tm_paredes.set_cell(Vector2i(j.obtener_posicion().y,k),1,Vector2(8,5))

func crear_arbol(tamaño_arbol: int) -> void:
	for i in tamaño_arbol:
		nodo_raiz.agregar_hijo(nodo_raiz.crear_hijo())
	for j in nodo_raiz._hijos:
		for k in range(tamaño_arbol): 
			j.agregar_hijo(j.crear_hijo())
		
		#print("nodos hijos:" + str(j._hijos))
	#print("nodos padre" + str(nodo_raiz._hijos))
