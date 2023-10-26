extends PanelContainer

@onready var node_name_label: Label = %NodeName

func init(graph_node_data: GraphNodeData):
    node_name_label.text = graph_node_data.name
