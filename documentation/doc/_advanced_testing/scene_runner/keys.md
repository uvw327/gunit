---
layout: default
title: Key Inputs
parent: Scene Runner
grand_parent: Advanced Testing
nav_order: 2
---


# Simulate Key Inputs

This page provides guidance on how to test key inputs in your scene using gunit.
For more detailed information on Godot keyboard events, please refer to
the [official Godot documentation](https://docs.godotengine.org/en/stable/tutorials/inputs/input_examples.html#keyboard-events){:target="_blank"}

## Function Overview

All functions listed below utilize the
[InputEventKey](https://docs.godotengine.org/en/stable/classes/class_inputeventkey.html#class-inputeventkey){:target="_blank"} class to simulate key input events.

|Function|Description|
|---|---|
|[simulate_key_pressed](#simulate_key_pressed) | Simulates that a key has been pressed. |
|[simulate_key_press](#simulate_key_press) | Simulates that a key is pressed. |
|[simulate_key_release](#simulate_key_release) | Simulates that a key has been released. |

## How to Simulate Key Interactions

To simulate key interactions in your scene, you can use the provided key simulation functions.
These functions allow you to mimic user key inputs for testing purposes. There are two main categories of functions:

* **Unfinished Functions**<br>
    Unfinished functions simulate the act of pressing a key without releasing it immediately.
    These are useful for simulating combinations, such as holding down a modifier key (e.g., Ctrl) while pressing another key (e.g., C for Ctrl+C).
    The interaction is completed when the key release function is called.

  * **[simulate_key_press](#simulate_key_press)**<br>
    Simulates pressing a key without releasing it.<br>
  * **[simulate_key_release](#simulate_key_release)**<br>
    Completes a key interaction by releasing the key.

* **Finalized Functions**<br>
    Finalized functions simulate a complete key press-and-release action in a single function call.

  * **[simulate_key_pressed](#simulate_key_pressed)**<br>
    Simulates a full key press-and-release interaction.
  
{% include advice.html
content="To ensure input events are processed correctly, you must wait at least one frame cycle after simulating inputs.
Use the <b>await runner.await_input_processed()</b> function to accomplish this."
%}
See [Synchronize Inputs Events]({{site.baseurl}}/advanced_testing/scene_runner/sync_inputs/#synchronize-inputs-events)

---

### simulate_key_pressed

The **simulate_key_pressed** function is used to simulate that a key has been pressed.

It takes the following arguments:

```gd
# key_code: an integer value representing the key code of the key being pressed, e.g. KEY_ENTER for the enter key.
func simulate_key_pressed(key_code: int) -> GdUnitSceneRunner:
```

Here is an example of how to use simulate_key_pressed:

```gd
var runner := scene_runner("res://test_scene.tscn")

# Simulate the enter key is pressed
runner.simulate_key_pressed(KEY_ENTER)
await runner.await_input_processed()

# Simulates key combination ctrl+C is pressed
runner.simulate_key_press(KEY_CTRL)
runner.simulate_key_pressed(KEY_C)
await runner.await_input_processed()
```

In this example, we simulate that the enter key is pressed and then we simulate that the key combination ctrl+C is pressed.
We use **[await_input_processed()]({{site.baseurl}}/advanced_testing/scene_runner/sync_inputs/#synchronize-inputs-events)** to ensure that the simulation
of the key press is complete before moving on to the next instruction.

### simulate_key_press

The **simulate_key_press** function is used to simulate that a key holding down.

It takes the following arguments:

```gd
# key_code : an integer value representing the key code of the key being pressed, e.g. KEY_ENTER for the enter key.
func simulate_key_press(key_code: int) -> GdUnitSceneRunner:
```

Here is an example of how to use simulate_key_press:

```gd
var runner := scene_runner("res://test_scene.tscn")

# Simulate the enter key is pressed
runner.simulate_key_press(KEY_ENTER)
await runner.await_input_processed()

# Simulates key combination ctrl+C is pressed
runner.simulate_key_press(KEY_CTRL)
runner.simulate_key_press(KEY_C)
await runner.await_input_processed()

# Simulates multi key combination ctrl+alt+C is pressed
runner.simulate_key_press(KEY_CTRL)
runner.simulate_key_press(KEY_ALT)
runner.simulate_key_press(KEY_C)
await runner.await_input_processed()
```

In this example, we simulate that the enter key is pressed and then we simulate that the key combination ctrl+C is pressed.
We use **[await_input_processed()]({{site.baseurl}}/advanced_testing/scene_runner/sync_inputs/#synchronize-inputs-events)** to ensure that the simulation
of the key press is complete before moving on to the next instruction.

### simulate_key_release

The **simulate_key_release** function is used to simulate that a key has been released.

It takes the following arguments:

```gd
# key_code : an integer value representing the key code of the key being released, e.g. KEY_ENTER for the enter key.
func simulate_key_release(key_code: int) -> GdUnitSceneRunner:
```

Here is an example of how to use simulate_key_release:

```gd
var runner := scene_runner("res://test_scene.tscn")

# Simulate the enter key is released
runner.simulate_key_release(KEY_ENTER)
await runner.await_input_processed()

# Simulates key combination ctrl+C is released
runner.simulate_key_release(KEY_CTRL)
runner.simulate_key_release(KEY_C)
await runner.await_input_processed()

# Simulates multi key combination ctrl+alt+C is released
runner.simulate_key_release(KEY_CTRL)
runner.simulate_key_release(KEY_ALT)
runner.simulate_key_release(KEY_C)
await runner.await_input_processed()
```

In this example, we simulate that the enter key is released and then we simulate that the key combination ctrl+C is released.
We use **[await_input_processed()]({{site.baseurl}}/advanced_testing/scene_runner/sync_inputs/#synchronize-inputs-events)** to ensure that the simulation
of the key press is complete before moving on to the next instruction.
