extends Node2D
#tm = tilemap

const TAMAÑO_MINIMO_HAB:Vector2 = Vector2(5,4)
const TAMAÑO_MAXIMO_HAB:Vector2 = Vector2(16,9)
const ITERACIONES: int = 4

const ESQ_SUP_IZQ: Vector2 = Vector2(18,0)
const ESQ_SUP_DER: Vector2 = Vector2(20,0)
const ESQ_INF_IZQ: Vector2 = Vector2(18,2)
const ESQ_INF_DER: Vector2 = Vector2(20,2)
const PARED_IZQ: Vector2 = Vector2(18,1)
const PARED_DER: Vector2 = Vector2(20,1)

const TAMAÑO_MAPA: Vector2 = Vector2(72,40)

@onready var tm_paredes: TileMapLayer = $TMParedes
