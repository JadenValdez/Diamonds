extends Node2D
@onready var color_rect: ColorRect = $ColorRect
var ColorName: String
var ColorColor: Color


func _ready() -> void:
	color_rect.modulate = ColorColor

#when a colored button is pressed, moves the corresponding block to the selected position
func _on_control_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed:
		match event.button_index:
			MOUSE_BUTTON_LEFT:
				SignalBus.select_color.emit(ColorName)
