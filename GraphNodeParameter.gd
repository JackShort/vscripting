extends HBoxContainer
class_name GraphNodeParameter

@onready var parameter_button: Button = %ParameterButton
@onready var label: Label = %Label

var _dragging := false
var line_segment: ParamConnector = null
var _hovering := false
var is_exec := false

func _input(event):
    if event is InputEventMouseButton and event.is_released() and _hovering and Global.graph.dragged_param:
        if event.button_index == MOUSE_BUTTON_LEFT:
            Global.graph.dragged_param.line_segment.attach_param(self, true)

func init(text: String, _is_exec = false):
    label.text = text
    is_exec = _is_exec

    if is_exec:
        parameter_button.modulate = Color.WHITE

func _ready():
    parameter_button.button_down.connect(_on_button_down)
    parameter_button.button_up.connect(_on_button_up)
    parameter_button.mouse_entered.connect(_on_mouse_entered)
    parameter_button.mouse_exited.connect(_on_mouse_exited)

func _on_button_down():
    _dragging = true
    Global.graph.dragged_param = self
    line_segment = ParamConnector.new()
    line_segment.attach_param(self)
    Global.add_node_to_graph(line_segment)

func _on_button_up():
    _dragging = false
    Global.graph.dragged_param = null

func _on_mouse_entered():
    _hovering = true

func _on_mouse_exited():
    _hovering = false

func _process(_delta):
    if not _dragging and line_segment and not line_segment.initialized:
        line_segment.queue_free()
        line_segment = null
