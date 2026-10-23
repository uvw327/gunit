---
layout: default
title: Signals
parent: Scene Runner
grand_parent: Advanced Testing
nav_order: 6
---

# Signals

In asynchronous programming, you often need to wait for signals to be emitted before proceeding with your program's execution.
The Scene Runner provides several functions to help you wait for these signals efficiently.
These functions allow you to synchronize your tests or operations with events occurring in the scene, ensuring that your program flows as expected.

## Function Overview

|Function|Description|
|---|---|
|[await_signal](#await_signal) | Waits for the specified signal to be emitted by the scene. If the signal is not emitted within the given timeout, the operation fails. |
|[await_signal_on](#await_signal_on) | Waits for the specified signal to be emitted by a particular source node. If the signal is not emitted within the given timeout, the operation fails. |

### await_signal

The **await_signal** function is used to pause execution until a specific signal is emitted by the scene.
This is particularly useful for testing or ensuring that certain conditions are met before continuing.
If the signal is not emitted within the specified timeout, the function will throw an error, indicating a failure in the expected signal emission.

It takes the following arguments:

```gd
## Waits for the specified signal to be emitted by the scene. If the signal is not emitted within the given timeout, the operation fails.
## [member signal_name] : The name of the signal to wait for
## [member args] : The signal arguments as an array
## [member timeout] : The maximum duration (in milliseconds) to wait for the signal to be emitted before failing
func await_signal(signal_name: String, args := [], timeout := 2000 ) -> void:
```

Here is an example of how to use await_signal:

```gd
var runner := scene_runner("res://test_scene.tscn")

# grab the colorRect instance from the scene
var box1: ColorRect = runner.get_property("_box1")
var box2: ColorRect = runner.get_property("_box2")
var box3: ColorRect = runner.get_property("_box3")

# call function `start_color_cycle` to start the color cycle
runner.invoke("start_color_cycle")

# Wait for the signals `panel_color_change` emitted by the scene by a maximum of 100ms or fails
await runner.await_signal("panel_color_change", [box1, Color.RED], 100)
await runner.await_signal("panel_color_change", [box2, Color.BLUE], 100)
await runner.await_signal("panel_color_change", [box3, Color.GREEN], 100)
```

### await_signal_on

The **await_signal_on** function works similarly to await_signal, but it targets a specific node (source) within the scene.
This is useful when you want to wait for signals from a particular node rather than the entire scene.

It takes the following arguments:

```gd
## Waits for the specified signal to be emitted by a particular source node. If the signal is not emitted within the given timeout, the operation fails.
## [member source] : the object from which the signal is emitted
## [member signal_name] : The name of the signal to wait for
## [member args] : The signal arguments as an array
## [member timeout] : tThe maximum duration (in milliseconds) to wait for the signal to be emitted before failing
func await_signal_on(source: Object, signal_name: String, args := [], timeout := 2000 ) -> void:
```

Here is an example of how to use await_signal_on:

```gd
var runner := scene_runner("res://test_scene.tscn")

# grab the colorRect instance from the scene
var box1: ColorRect = runner.get_property("_box1")
var box2: ColorRect = runner.get_property("_box2")
var box3: ColorRect = runner.get_property("_box3")

# call function `start_color_cycle` how is triggering the box1..box3 to emit the signal `color_change`
runner.start_color_cycle()

# Wait for the signals `color_change` emitted by the components `box1`, `box2` and `box3` by a maximum of 100ms or fails
await runner.await_signal_on(box1, "color_change", [Color.RED], 100)
await runner.await_signal_on(box2, "color_change", [Color.BLUE], 100)
await runner.await_signal_on(box3, "color_change", [Color.GREEN], 100)
```
