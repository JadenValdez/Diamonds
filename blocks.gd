extends Node2D

var BlockName: String
var BlockColor: Color
var BlockWeight: int
@onready var color_rect: ColorRect = $ColorRect
@onready var label: Label = $Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	
	color_rect.modulate = BlockColor
	label.text = BlockName
	print(BlockName + " " + str(BlockWeight))
	SignalBus.move_block.connect(_move_block)
	SignalBus.heavier.connect(_heavier)
	SignalBus.lighter.connect(_lighter)

#moves the block to the selected position
func _move_block(color_name, block_position) -> void:
	if color_name == BlockName:
		position = block_position

#if on the heavier side, moves down
func _heavier(color_name) -> void:
	if color_name == BlockName:
		position += Vector2(0, 100)
		
#if on the lighter side, moves up
func _lighter(color_name) -> void:
	if color_name == BlockName:
		position -= Vector2(0, 100)
