extends HBoxContainer
class_name GraphNodeParameter

@onready var parameter_button: Button = %ParameterButton
@onready var label: Label = %Label

var _dragging := false
var line_segment: ParamConnector = null
var _hovering := false

func _input(event):
    if event is InputEventMouseButton and event.is_released() and _hovering and Global.graph.dragged_param:
        if event.button_index == MOUSE_BUTTON_LEFT:
            print("hello")
            Global.graph.dragged_param.line_segment.points[1] = parameter_button.global_position + parameter_button.size / 2
            Global.graph.dragged_param.line_segment.initialized = true

func init(text: String):
    label.text = text

func _ready():
    parameter_button.button_down.connect(_on_button_down)
    parameter_button.button_up.connect(_on_button_up)
    parameter_button.mouse_entered.connect(_on_mouse_entered)
    parameter_button.mouse_exited.connect(_on_mouse_exited)

func _on_button_down():
    _dragging = true
    Global.graph.dragged_param = self

func _on_button_up():
    _dragging = false
    Global.graph.dragged_param = null

func _on_mouse_entered():
    _hovering = true

func _on_mouse_exited():
    _hovering = false

func _process(_delta):
    if _dragging:
        if not line_segment:
            line_segment = ParamConnector.new()
            Global.add_node_to_graph(line_segment)
            line_segment.points = [parameter_button.global_position + parameter_button.size / 2, get_global_mouse_position()]
            line_segment.width = 1.5
        else:
            line_segment.points[1] = get_global_mouse_position()
    if not _dragging and line_segment and not line_segment.initialized:
        line_segment.queue_free()
        line_segment = null
