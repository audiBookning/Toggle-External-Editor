@tool
extends EditorPlugin

""" 

settings for GDScript at
	text_editor/external/use_external_editor
settings for NET at
	dotnet/editor/external_editor

dotnet/editor/external_editor is a select widget with at the time i am writing this
	(i can't find how to programmatically get the keys of the settings. I can only get the values...):
	0 - disabled
	1 - visual studio
	2 - monodevelop
	3 - visual studio code
	4 - jet brain rider
	5 - custom
Note that +1 must be added to the index when setting the value
for example, for vs code we have
settings.set("dotnet/editor/external_editor", 3+1)

""" 

var checkbox = CheckBox.new()
var settings = get_editor_interface().get_editor_settings()

func _enter_tree():
	checkbox.text = "Use External Editor"

	# the following condition is only for the NET version
	checkbox.set_pressed(settings.get("dotnet/editor/external_editor"))

	# Uncomment the following line for the GDsScript exclusive godot editor
	#checkbox.set_pressed(settings.get("text_editor/external/use_external_editor"))

	checkbox.connect("toggled", Callable(self, "_on_CheckBox_toggled"))
	add_control_to_container(EditorPlugin.CONTAINER_TOOLBAR, checkbox)

func _exit_tree():
	remove_control_from_container(EditorPlugin.CONTAINER_TOOLBAR, checkbox)
	checkbox.free()

func _on_CheckBox_toggled(pressed):
	# maintain this line to get vs code to work with both gds and c#
	settings.set("text_editor/external/use_external_editor", pressed)
	
	# the following condition is only for the NET version
	if pressed:
		# 4 for Visual Studio Code
		settings.set("dotnet/editor/external_editor", 4)
	else:
		settings.set("dotnet/editor/external_editor", 0)
		

