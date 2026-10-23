---
layout: default
title: Mouse Inputs
parent: Scene Runner
grand_parent: Advanced Testing
nav_order: 3
---


# Simulate Mouse Inputs

This page provides guidance on how to test mouse inputs in your scene using gunit.
For more detailed information on Godot mouse events, please refer to the [official Godot documentation](https://docs.godotengine.org/en/stable/tutorials/inputs/input_examples.html#mouse-events){:target="_blank"}

## Function Overview

All functions listed below utilize the listed classes to simulate mouse input events.

* [InputEventMouse](https://docs.godotengine.org/en/stable/classes/class_inputeventmouse.html){:target="_blank"} class to simulate mouse input events.
* [InputEventMouseButton](https://docs.godotengine.org/en/stable/classes/class_inputeventmousebutton.html){:target="_blank"} class to simulate mouse input events.
* [InputEventMouseMotion](https://docs.godotengine.org/en/stable/classes/class_inputeventmousemotion.html){:target="_blank"} class to simulate mouse input events.

|Function|Description|
|---|---|
|[set_mouse_position]({{site.baseurl}}/advanced_testing/scene_runner/mouse/#set_mouse_position) | Sets the mouse cursor position for the current Viewport.|
|[get_mouse_position]({{site.baseurl}}/advanced_testing/scene_runner/mouse/#get_mouse_position) | Returns the mouse's position in this Viewport using the coordinate system of this Viewport.|
|[simulate_mouse_move]({{site.baseurl}}/advanced_testing/scene_runner/mouse/#simulate_mouse_move) | Simulates a mouse moved to final position. |
|[simulate_mouse_move_relative]({{site.baseurl}}/advanced_testing/scene_runner/mouse/#simulate_mouse_move_relative) | Simulates a mouse move to the relative coordinates (offset). |
|[simulate_mouse_move_absolute]({{site.baseurl}}/advanced_testing/scene_runner/mouse/#simulate_mouse_move_absolute) | Simulates a mouse move to the absolute coordinates. |
|[simulate_mouse_button_pressed]({{site.baseurl}}/advanced_testing/scene_runner/mouse/#simulate_mouse_button_pressed) | Simulates a mouse button pressed. |
|[simulate_mouse_button_press]({{site.baseurl}}/advanced_testing/scene_runner/mouse/#simulate_mouse_button_press) | Simulates a mouse button press (holding). |
|[simulate_mouse_button_release]({{site.baseurl}}/advanced_testing/scene_runner/mouse/#simulate_mouse_button_release) | Simulates a mouse button released. |

## How to Simulate Mouse Interactions

To simulate mouse interactions in your scene, you can use the provided mouse simulation functions.
These functions allow you to mimic user mouse inputs for testing purposes. There are two main categories of functions:

* **Unfinished Functions**<br>
    Unfinished functions simulate the act of pressing a key without releasing it immediately.
* These are useful for simulating combinations, such as holding down a modifier mouse button (e.g., Left-Button) while pressing another mouse button
  (e.g., Right-Button). The interaction is completed when mouse release function is called.

  * **[set_mouse_position](#set_mouse_position)**<br>
    Simulates moving the mouse cursor to a specified position.<br>
  * **[simulate_mouse_button_press](#simulate_mouse_button_press)**<br>
    Simulates pressing a specific mouse button without releasing it.<br>
  * **[simulate_mouse_button_release](#simulate_mouse_button_release)**<br>
    Simulates releasing a specific mouse button that was previously pressed.

* **Finalized Functions**<br>
    Finalized functions simulate a complete mouse press-and-release action in a single function call.

  * **[get_mouse_position](#get_mouse_position)**<br>
    Retrieves the current position of the mouse cursor.<br>
  * **[simulate_mouse_button_pressed](#simulate_mouse_button_pressed)**<br>
    Simulates a mouse button press and release action, effectively performing a click.<br>
  * **[simulate_mouse_move](#simulate_mouse_move)**<br>
    Simulates moving the mouse cursor relative to its current position.<br>
  * **[simulate_mouse_move_relative](#simulate_mouse_move_relative)**<br>
    Moves the mouse cursor by a specified offset from its current position.<br>
  * **[simulate_mouse_move_absolute](#simulate_mouse_move_absolute)**<br>
    Moves the mouse cursor to an absolute position within the window or screen.
  
{% include advice.html
content="To ensure input events are processed correctly, you must wait at least one frame cycle after simulating inputs.
Use the <b>await runner.await_input_processed()</b> function to accomplish this."
%}
See [Synchronize Inputs Events]({{site.baseurl}}/advanced_testing/scene_runner/sync_inputs/#synchronize-inputs-events)

---

### set_mouse_position

The **set_mouse_position** function is used to set the mouse cursor to given position of the viewport.

It takes the following arguments:

```gd
## Sets the mouse position to the specified vector, provided in pixels and relative to an origin at the upper left corner of the currently focused Window Manager game window.
## [member position] : The absolute position in pixels as Vector2
func set_mouse_position(position: Vector2) -> GdUnitSceneRunner:
```

Here is an example of how to use set_mouse_position:

```gd
var runner := scene_runner("res://test_scene.tscn")

# sets the current mouse position to 100, 100
runner.set_mouse_position(Vector2(100, 100))
await runner.await_input_processed()
```

We use **[await_input_processed()]({{site.baseurl}}/advanced_testing/scene_runner/sync_inputs/#synchronize-inputs-events)** to ensure that the simulation
of the mouse input is complete before moving on to the next instruction.

### get_mouse_position

The **get_mouse_position** function is used to get the mouse cursor position from the current viewport.

```gd
## Returns the mouse's position in this Viewport using the coordinate system of this Viewport.
func get_mouse_position() -> Vector2:
```

Here is an example of how to use get_mouse_position:

```gd
var runner := scene_runner("res://test_scene.tscn")

# gets the current mouse position
var mouse_position := runner.get_mouse_position()
```

### simulate_mouse_move

The **simulate_mouse_move** function is used to simulate the movement of the mouse cursor to a given position on the screen.

It takes the following arguments:

```gd
# position: representing the final position of the mouse cursor after the movement is completed
func simulate_mouse_move(position: Vector2) -> GdUnitSceneRunner:
```

Here is an example of how to use simulate_mouse_move:

```gd
var runner := scene_runner("res://test_scene.tscn")

# Set mouse position to a initial position
runner.set_mouse_pos(Vector2(160, 20))
await runner.await_input_processed()

# Simulates a mouse move to final position 200, 40
runner.simulate_mouse_move(Vector2(200, 40))
await runner.await_input_processed()
```

We use **[await_input_processed()]({{site.baseurl}}/advanced_testing/scene_runner/sync_inputs/#synchronize-inputs-events)** to ensure that the simulation
of the mouse input is complete before moving on to the next instruction.

### simulate_mouse_move_relative

The **simulate_mouse_move_relative** function simulates a mouse move to a relative position within a specified time.

It takes the following arguments:

```gd
## Simulates a mouse move to the relative coordinates (offset).
## [member relative] : The relative position, indicating the mouse position offset.
## [member time] : The time to move the mouse by the relative position in seconds (default is 1 second).
## [member trans_type] : Sets the type of transition used (default is TRANS_LINEAR).
func simulate_mouse_move_relative(relative: Vector2, time: float = 1.0, trans_type: Tween.TransitionType = Tween.TRANS_LINEAR) -> GdUnitSceneRunner:
```

Here is an example of how to use simulate_mouse_move_relative:

```gd
var runner := scene_runner("res://test_scene.tscn")

# Set mouse position to an initial position
runner.set_mouse_pos(Vector2(10, 20))
await runner.await_input_processed()

# Simulate a mouse move from the current position to the relative position within 1 second
# the final position will be (410, 220) when is completed
await runner.simulate_mouse_move_relative(Vector2(400, 200), 1)
```

### simulate_mouse_move_absolute

The **simulate_mouse_move_absolute** function simulates a mouse move to an absolute position within a specified time.

It takes the following arguments:

```gd
## Simulates a mouse move to the absolute coordinates.
## [member position] : The final position of the mouse.
## [member time] : The time to move the mouse to the final position in seconds (default is 1 second).
## [member trans_type] : Sets the type of transition used (default is TRANS_LINEAR).
func simulate_mouse_move_absolute(position: Vector2, time: float = 1.0, trans_type: Tween.TransitionType = Tween.TRANS_LINEAR) -> GdUnitSceneRunner:
```

Here is an example of how to use simulate_mouse_move_absolute:

```gd
var runner := scene_runner("res://test_scene.tscn")

# Set mouse position to an initial position
runner.set_mouse_pos(Vector2(10, 20))
await runner.await_input_processed()

# Simulate a mouse move from the current position to the absolute position within 1 second
# the final position will be (400, 200) when is completed
await runner.simulate_mouse_move_absolute(Vector2(400, 200), 1)
```

### simulate_mouse_button_pressed

The **simulate_mouse_button_pressed** function is used to simulate that a mouse button is pressed.

It takes the following arguments:

```gd
# button_index: The mouse button identifier, one of the ButtonList button or button wheel constants.
# double_click: set to true to simulate a double-click
func simulate_mouse_button_pressed(button_index: MouseButton, double_click := false) -> GdUnitSceneRunner:
```

Here is an example of how to use simulate_mouse_button_pressed:

```gd
var runner := scene_runner("res://test_scene.tscn")

# Simulates pressing the left mouse button
runner.simulate_mouse_button_pressed(BUTTON_LEFT)
await runner.await_input_processed()
```

We use **[await_input_processed()]({{site.baseurl}}/advanced_testing/scene_runner/sync_inputs/#synchronize-inputs-events)** to ensure that the simulation
of the mouse input is complete before moving on to the next instruction.

### simulate_mouse_button_press

The **simulate_mouse_button_press** function is used to simulate holding down a mouse button.

It takes the following arguments:

```gd
# buttonIndex: The mouse button identifier, one of the ButtonList button or button wheel constants.
# button_index: Set to true to simulate a double-click
func simulate_mouse_button_press(button_index: int, double_click := false) -> GdUnitSceneRunner:
```

Here is an example of how to use simulate_mouse_button_press:

```gd
var runner := scene_runner("res://test_scene.tscn")

# simulates mouse left button is press
runner.simulate_mouse_button_press(BUTTON_LEFT)
await runner.await_input_processed()
```

We use **[await_input_processed()]({{site.baseurl}}/advanced_testing/scene_runner/sync_inputs/#synchronize-inputs-events)** to ensure that the simulation
of the mouse input is complete before moving on to the next instruction.

### simulate_mouse_button_release

The **simulate_mouse_button_release** function is used to simulate a mouse button is released.

It takes the following arguments:

```gd
# button_index: The mouse button identifier, one of the ButtonList button or button wheel constants.
func simulate_mouse_button_release(button_index: int) -> GdUnitSceneRunner:
```

Here is an example of how to use simulate_mouse_button_release:

```gd
var runner := scene_runner("res://test_scene.tscn")

# Simulates a mouse left button is released
runner.simulate_mouse_button_release(BUTTON_LEFT)
await runner.await_input_processed()
```

We use **[await_input_processed()]({{site.baseurl}}/advanced_testing/scene_runner/sync_inputs/#synchronize-inputs-events)** to ensure that the simulation
of the mouse input is complete before moving on to the next instruction.
