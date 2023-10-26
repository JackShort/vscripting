extends Node2D

@onready var graph_node_scene = preload("res://GraphNode.tscn")

func _input(event):
    if event is InputEventMouseButton:
        if event.button_index == MOUSE_BUTTON_RIGHT:
            _add_node(get_global_mouse_position())

func _add_node(mouse_position: Vector2):
    var graph_node = graph_node_scene.instantiate()
    add_child(graph_node)
    graph_node.global_position = mouse_position
    graph_node.init()
