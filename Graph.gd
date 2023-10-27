extends Node2D
class_name Graph

@onready var search_node_scene = preload("res://Searchbar.tscn")

var dragged_param: GraphNodeParameter = null

var _search_bar_node: Control = null
var _selected_node: ScriptingGraphNode = null

func _ready():
    Global.graph = self

func _input(event):
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_RIGHT and event.is_pressed():
            if _search_bar_node:
                _search_bar_node.queue_free()
                _search_bar_node = null

            _search_bar_node = search_node_scene.instantiate()
            add_child(_search_bar_node)
            _search_bar_node.node_added.connect(_on_node_added)
            _search_bar_node.global_position = get_global_mouse_position()
    
    if Input.is_action_pressed("ui_cancel"):
        if _selected_node:
            update_selected_node(null)

        if _search_bar_node:
            _search_bar_node.queue_free()
            _search_bar_node = null
    
    if Input.is_action_pressed("ui_text_backspace") and _selected_node:
        _selected_node.queue_free()
        _selected_node = null

func update_selected_node(graph_node: ScriptingGraphNode):
    if _selected_node:
        _selected_node.deselect_node()
    _selected_node = graph_node

func _on_node_added():
    if _search_bar_node:
        _search_bar_node.queue_free()
        _search_bar_node = null
