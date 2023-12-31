extends HBoxContainer
class_name GraphNodeParameter

@onready var parameter_button: Button = %ParameterButton
@onready var label: Label = %Label
@onready var hardcoded_input: LineEdit = %HardcodedInput

var parent_node_sig := ""
var _dragging := false
var line_segment: ParamConnector = null
var _hovering := false
var is_exec := false

func _input(event):
    if event is InputEventMouseButton and event.is_released() and _hovering and Global.graph.dragged_param:
        if event.button_index == MOUSE_BUTTON_LEFT:
            Global.graph.dragged_param.line_segment.attach_param(self, true)

func init(text: String, parent_sig: String, _is_exec = false, hardcoded = false, parameter_name = ""):
    label.text = text
    is_exec = _is_exec
    parent_node_sig = parent_sig

    if is_exec:
        parameter_button.modulate = Color.WHITE
    
    if hardcoded:
        hardcoded_input.visible = true
        parameter_button.visible = false
    
    if parameter_name != "":
        Global.graph.graph_dict[parent_node_sig]["outputs"] = {
            "value": Global.vm_state["parameters"][parameter_name]
        }

func _ready():
    parameter_button.button_down.connect(_on_button_down)
    parameter_button.button_up.connect(_on_button_up)
    parameter_button.mouse_entered.connect(_on_mouse_entered)
    parameter_button.mouse_exited.connect(_on_mouse_exited)
    hardcoded_input.text_changed.connect(_set_hardcoded_value)

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

func _set_hardcoded_value(text: String):
    Global.graph.graph_dict[parent_node_sig]["outputs"] = {
        "value": text
    }
