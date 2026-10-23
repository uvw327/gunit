---
layout: default
title: Accessors
parent: Scene Runner
grand_parent: Advanced Testing
nav_order: 8
---

# Scene Accessors

In addition to simulating the scene, the SceneRunner provides functions to access the scene's nodes.
These functions are useful for debugging and testing purposes.

For example, you can use **find_child()** to retrieve a specific node in the scene, and then call its methods or change its properties to test its behavior.

By using these functions, you can gain greater control over the scene and test various scenarios,
making it easier to find and fix bugs and improve the overall quality of your game or application.

## Function Overview

| Function                                                                                | Description                                                                  |
|-----------------------------------------------------------------------------------------|------------------------------------------------------------------------------|
| [get_property]({{site.baseurl}}/advanced_testing/scene_runner/accessors/#get_property) | Return the current value of a property.                                      |
| [set_property]({{site.baseurl}}/advanced_testing/scene_runner/accessors/#set_property) | Sets the value of the property with the specified name.                      |
| [find_child]({{site.baseurl}}/advanced_testing/scene_runner/accessors/#find_child)     | Searches for the specified node with the name in the current scene.          |
| [invoke]({{site.baseurl}}/advanced_testing/scene_runner/accessors/#invoke)             | Executes the function specified by name in the scene and returns the result. |
| [scene]({{site.baseurl}}/advanced_testing/scene_runner/accessors/#scene)                | Gets access to the current running scene.                                    |

### get_property

The **get_property** function returns the current value of the property from the current scene.

It takes the following arguments:

```gd
# name: the name of the property
# returns the actual value of the property
func get_property(name: String) -> Variant:
```

Here is an example of how to use get_property:

```gd
var runner := scene_runner("res://test_scene.tscn")

# Returns the current property `_door_color` from the scene
var color: ColorRect = runner.get_property("_door_color")
```

### set_property

The **set_property** function sets the value of a property with the specified name.

It takes the following arguments:

```gd
# name: the name of the property.
# value: the value to be assigned to the property.
# returns true|false depending on valid property name.
func set_property(name: String, value: Variant) -> bool:
```

Here is an example of how to use set_property:

```gd
var runner := scene_runner("res://test_scene.tscn")

# Sets the property `_door_color` to Red
runner.set_property("_door_color", Color.RED)
```

### find_child

The **find_child** function searches for a node with the specified name in the current scene and returns it. If the node is not found, it returns null.

```gd
## [member name] : the name of the node to find
## [member recursive] : enables/disables seraching recursive
## [member owned] : is set to true it only finds nodes who have an assigned owner
## [member return] : the node if find otherwise null
func find_child(name: String, recursive := true, owned := false) -> Node:
```

Here is an example of how to use find_child:

```gd
 var runner := scene_runner("res://test_scene.tscn")
 
 # Searchs for node `Spell` inside the scene tree
 var spell: Node = runner.find_child("Spell")
```

### invoke

The **invoke** function runs the function specified by given name in the scene and returns the result.

It takes the following arguments:

```gd
# name: the name of the function to execute
# optional function args 0..9
# return: the function result
func invoke(name: String, arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9):
```

Here is an example of how to use invoke:

```gd
var runner := scene_runner("res://test_scene.tscn")

# Invokes the function `start_color_cycle`
runner.invoke("start_color_cycle")
```

### scene

The **scene** function gets access to current loaded and managed scene by the SceneRunner.

```gd
## Returns the scene instance that is currently loaded and managed by this SceneRunner.
## [member return] : The node representing the current running scene
func scene() -> Node:
```

Here is an example of how to use scene():

```gd
var runner := scene_runner("res://test_scene.tscn")

# Gets access to the scene instance
var my_scene := runner.scene()
```
