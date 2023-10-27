extends Node
class_name GraphNodeData

@export var is_executable := true
@export var can_execute := true
@export var inputs: Array[String] = []
@export var outputs: Array[String] = []

func exec(_node_sig):
    pass
