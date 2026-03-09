extends Node2D
@onready var color_rect: ColorRect = $ColorRect
var ColorName: String
var ColorColor: Color
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	color_rect.modulate = ColorColor

func _on_control_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				SignalBus.select_color.emit(ColorName)
