extends Node2D

@onready var search_node_scene = preload("res://Searchbar.tscn")

var _search_bar_node: Control = null

func _input(event):
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_RIGHT:
            if _search_bar_node:
                _search_bar_node.queue_free()
                _search_bar_node = null

            _search_bar_node = search_node_scene.instantiate()
            add_child(_search_bar_node)
            _search_bar_node.node_added.connect(_on_node_added)
            _search_bar_node.global_position = get_global_mouse_position()
    
    if Input.is_action_pressed("ui_cancel") and _search_bar_node:
        _search_bar_node.queue_free()
        _search_bar_node = null

func _on_node_added():
    if _search_bar_node:
        _search_bar_node.queue_free()
        _search_bar_node = null
