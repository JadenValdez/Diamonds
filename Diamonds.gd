extends Node2D


@onready var equal: Label = $Equal
@onready var answer: Label = $Answer
@onready var _1: Label = $"1"
@onready var _2: Label = $"2"
@onready var _3: Label = $"3"
@onready var _4: Label = $"4"
@onready var _5: Label = $"5"
@onready var _6: Label = $"6"
@onready var _7: Label = $"7"
@onready var _8: Label = $"8"

var random_number = 3847
var encrypt = 0
var encrypt_result = 0
var Colors = {
	"Red": Color(1, 0, 0, 1),
	"Orange": Color(1, 0.64705884, 0, 1),
	"Yellow": Color(1, 1, 0, 1),
	"Green": Color(0, 1, 0, 1),
	"Blue": Color(0, 0, 1, 1),
	"Indigo": Color(0.29411766, 0, 0.50980395, 1),
	"Violet": Color(0.93333334, 0.50980395, 0.93333334, 1),
}
var ColorsWeights = {}

var LeftScale = {}
var RightScale = {}

@onready var pointer: Polygon2D = $Pointer

var current_side = "Left"
var rng = RandomNumberGenerator.new()
var Weights = [1, 2, 3, 4, 5, 6, 7, 8]
var result: int
var location = Vector2(250, 600)
const BLOCKS = preload("res://Blocks.tscn")
const BUTTON = preload("res://Button.tscn")
var left_location = Vector2(200, 300)
var right_location = Vector2(700, 300)

var left_weight = 0
var right_weight = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalBus.select_color.connect(_select_color)
	set_up()
	set_labels()
	set_answers()

func set_up() -> void:
	for block in Colors:
		#makes a block for each color
		var instance = BLOCKS.instantiate()
		instance.BlockName = block
		instance.BlockColor = Colors[block]
		
		#assigns each block a random weight, without using a weight corresponding to a previous block
		result = rng.randi_range(0, Weights.size()-1)
		instance.BlockWeight = Weights[result]
		ColorsWeights[block] = Weights[result]
		#adds color-weight combo to answer key
		answer.text += block + " " + str(Weights[result]) + "
		"
		Weights.erase(Weights[result])
		
		instance.position = Vector2(-300, -100)
		add_child(instance)
		
		#makes a button corresponding to each color
		var instance2 = BUTTON.instantiate()
		instance2.ColorName = block
		instance2.position = location
		instance2.ColorColor = Colors[block]
		location += Vector2(100, 0)
		add_child(instance2)
		

#creates a label for which weigh corresponds to what color (originally made for 2 player mode)
func set_labels() -> void:
	for colour in ColorsWeights:
		match ColorsWeights[colour]:
			1:
				_1.text = colour + " 1"
			2:
				_2.text = colour + " 2"
			3:
				_3.text = colour + " 3"
			4:
				_4.text = colour + " 4"
			5:
				_5.text = colour + " 5"
			6:
				_6.text = colour + " 6"
			7:
				_7.text = colour + " 7"
			8:
				_8.text = colour + " 8"

#encrypts the answer so it can be checked against without actually revealing it (originally made for 2 player mode)
func set_answers() -> void:
	for colour in ColorsWeights:
		match colour:
			"Red":
				encrypt += ColorsWeights[colour] * 1000000
			"Orange":
				encrypt += ColorsWeights[colour] * 100000
			"Yellow":
				encrypt += ColorsWeights[colour] * 10000
			"Green":
				encrypt += ColorsWeights[colour] * 1000
			"Blue":
				encrypt += ColorsWeights[colour] * 100
			"Indigo":
				encrypt += ColorsWeights[colour] * 10
			"Violet":
				encrypt += ColorsWeights[colour] * 1
	encrypt_result = encrypt * random_number
	print("
	
	
	
	
	
	
	
	
	
	" + str(encrypt_result))

#puts the colored block on the selected side when the corresponding button is pressed
func _select_color(color_name) -> void:
	if current_side == "Left":
		if LeftScale.has(color_name):
			return
		LeftScale[color_name] = ColorsWeights[color_name]
		SignalBus.move_block.emit(color_name, left_location)
		left_location -= Vector2(0, 50)
		
	else:
		if RightScale.has(color_name):
			return
		RightScale[color_name] = ColorsWeights[color_name]
		SignalBus.move_block.emit(color_name, right_location)
		right_location -= Vector2(0, 50)

#weighs both sides against each other, then displays the result
func _on_button_pressed() -> void:
	left_weight = 0
	right_weight = 0
	for left in LeftScale:
		left_weight += LeftScale[left]
	for right in RightScale:
		right_weight += RightScale[right]
		
	if left_weight > right_weight:
		for left in LeftScale:
			SignalBus.heavier.emit(left)
		for right in RightScale:
			SignalBus.lighter.emit(right)
	elif right_weight > left_weight:
		for right in RightScale:
			SignalBus.heavier.emit(right)
		for left in LeftScale:
			SignalBus.lighter.emit(left)
	else:
		equal.show()

#changes the selected side
func _on_button_2_pressed() -> void:
	if current_side == "Left":
		current_side = "Right"
		pointer.position = Vector2(800, 350)
	else:
		current_side = "Left"
		pointer.position = Vector2(300, 350)

#resets the weighing process
func _on_button_3_pressed() -> void:
	equal.hide()
	left_location = Vector2(200, 300)
	right_location = Vector2(700, 300)
	LeftScale = {}
	RightScale = {}
	for block in Colors:
		SignalBus.move_block.emit(block, Vector2(-300, -100))

#shows the answer
func _on_show_answer_pressed() -> void:
	answer.show()
