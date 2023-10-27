extends PanelContainer
class_name ScriptingGraphNode

@onready var graph_node_parameter = preload("res://GraphNodeParameter.tscn")
@onready var node_name_label: Label = %NodeName
@onready var input_container: VBoxContainer = %InputContainer
@onready var output_container: VBoxContainer = %OutputContainer

var _mouse_entered := false
var _selected := false
var _dragging := false
var _dragging_offset := Vector2.ZERO

func _input(event):
    if event is InputEventMouseButton and event.is_pressed() and _mouse_entered:
        if event.button_index == MOUSE_BUTTON_LEFT:
            select_node()
            _dragging = true
            _dragging_offset = global_position - get_global_mouse_position()

    if event is InputEventMouseButton and event.is_released() and _dragging:
        if event.button_index == MOUSE_BUTTON_LEFT:
            _dragging = false

func _unhandled_input(event):
    if event is InputEventMouseButton and event.is_pressed() and _selected:
        if event.button_index == MOUSE_BUTTON_LEFT:
            Global.graph.update_selected_node(null)

func init(graph_node_data: GraphNodeData):
    node_name_label.text = graph_node_data.name
    if graph_node_data.is_executable:
        add_parameter("Exec", false, true)
    if graph_node_data.can_execute:
        add_parameter("Exec", true, true)
    
    for i in graph_node_data.inputs:
        add_parameter(i)

    for i in graph_node_data.outputs:
        add_parameter(i, true)

func _ready():
    for child in input_container.get_children():
        input_container.remove_child(child)
        child.queue_free()

    for child in output_container.get_children():
        output_container.remove_child(child)
        child.queue_free()

    mouse_entered.connect(func(): _on_mouse_entered())
    mouse_exited.connect(func(): _mouse_entered = false)

func _physics_process(_delta):
    if _dragging:
        global_position = get_global_mouse_position() + _dragging_offset

func select_node():
    if _selected:
        return

    _selected = true
    _set_panel_border_width(1)
    Global.graph.update_selected_node(self)

func deselect_node():
    _selected = false
    _set_panel_border_width(0)

func _set_panel_border_width(width: int):
    var panel: StyleBoxFlat = get_theme_stylebox('panel')
    panel.border_width_top = width
    panel.border_width_bottom = width
    panel.border_width_right = width
    panel.border_width_left = width

func _on_mouse_entered():
    _mouse_entered = true

func add_parameter(param_name: String, output = false, is_exec = false):
    var param = graph_node_parameter.instantiate()

    if output:
        output_container.add_child(param)
        param.move_child(param.get_children()[1], 0)
        param.alignment = 2
        param.init(param_name, is_exec)
    else:
        input_container.add_child(param)
        param.init(param_name, is_exec)
