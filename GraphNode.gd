extends PanelContainer
class_name ScriptingGraphNode

@onready var node_name_label: Label = %NodeName

var _mouse_entered := false
var _selected = false

func _input(event):
    if event is InputEventMouseButton and event.is_pressed() and _mouse_entered:
        if event.button_index == MOUSE_BUTTON_LEFT:
            _select_node()

func init(graph_node_data: GraphNodeData):
    node_name_label.text = graph_node_data.name

func _ready():
    mouse_entered.connect(func(): _on_mouse_entered())
    mouse_exited.connect(func(): _mouse_entered = false)

func _select_node():
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
    print("entering")
    _mouse_entered = true
