---
layout: default
title: Object Assert
parent: Asserts
---

# Object Assertions

An assertion tool to verify Objects.

**GdUnitObjectAssert**<br>

|Function|Description|
|--- | --- |
|[is_null]({{site.baseurl}}/testing/assert-object/#is_null) | Verifies that the current value is null.|
|[is_not_null]({{site.baseurl}}/testing/assert-object/#is_not_null) | Verifies that the current value is not null.|
|[is_equal]({{site.baseurl}}/testing/assert-object/#is_equal) | Verifies that the current value is equal to expected one.|
|[is_not_equal]({{site.baseurl}}/testing/assert-object/#is_not_equal) | Verifies that the current value is not equal to expected one.|
|[is_same]({{site.baseurl}}/testing/assert-object/#is_same) | Verifies that the current value is the same as the given one.|
|[is_not_same]({{site.baseurl}}/testing/assert-object/#is_not_same) | Verifies that the current value is not the same as the given one.|
|[is_instanceof]({{site.baseurl}}/testing/assert-object/#is_instanceof) | Verifies that the current value is an instance of the given type.|
|[is_not_instanceof]({{site.baseurl}}/testing/assert-object/#is_not_instanceof) | Verifies that the current value is not an instance of the given type.|
|[is_valid]({{site.baseurl}}/testing/assert-object/#is_valid) | Verifies that the current value is a valid, unfreed instance.|

---

## Object Assert Examples

### is_equal

Verifies that the current value is equal to expected one.
```gd
func assert_object(<current>).is_equal(<expected>) -> GdUnitObjectAssert
```
```gd
# this assertion succeeds
assert_object(Mesh.new()).is_equal(Mesh.new())

# should fail because the current is an Mesh and we expect equal to a Skin
assert_object(Mesh.new()).is_equal(Skin.new())
```

### is_not_equal

Verifies that the current value is not equal to expected one.
```gd
func assert_object(<current>).is_not_equal(<expected>) -> GdUnitObjectAssert
```
```gd
# this assertion succeeds
assert_object(Mesh.new()).is_not_equal(Skin.new())

# should fail because the current is an Mesh and we expect not equal to a Mesh
assert_object(Mesh.new()).is_not_equal(Mesh.new())
```

### is_null

Verifies that the current value is null.
```gd
func assert_object(<current>).is_null() -> GdUnitObjectAssert
```
```gd
# this assertion succeeds
assert_object(null).is_null()

# should fail because it the current value is an Mesh and not null
assert_object(Mesh.new()).is_null()
```

### is_not_null

Verifies that the current value is not null.
```gd
func assert_object(<current>).is_not_null() -> GdUnitObjectAssert
```
```gd
# this assertion succeeds
assert_object(Mesh.new()).is_not_null()

# should fail because the current value is null
assert_object(null).is_not_null()
```

### is_same

Verifies that the current value is the same as the given one.
```gd
func assert_object(<current>).is_same(<expected>) -> GdUnitObjectAssert
```
```gd
# this assertion succeeds
var obj1 = Node.new()
var obj2 = obj1
var obj3 = obj1.duplicate()
assert_object(obj1).is_same(obj1)
assert_object(obj1).is_same(obj2)
assert_object(obj2).is_same(obj1)

# should fail because because the current is not same instance as expected value
assert_object(null).is_same(obj1)
assert_object(obj1).is_same(obj3)
assert_object(obj3).is_same(obj1)
assert_object(obj3).is_same(obj2)
```

### is_not_same

Verifies that the current value is not the same as the given one.
```gd
func assert_object(<current>).is_not_same(<expected>) -> GdUnitObjectAssert
```
```gd
# this assertion succeeds
var obj1 = Node.new()
var obj2 = obj1
var obj3 = obj1.duplicate()
assert_object(null).is_not_same(obj1)
assert_object(obj1).is_not_same(obj3)
assert_object(obj3).is_not_same(obj1)
assert_object(obj3).is_not_same(obj2)

# should fail because because the current is the same instance as expected value
assert_object(obj1).is_not_same(obj1)
assert_object(obj1).is_not_same(obj2)
assert_object(obj2).is_not_same(obj1)
```

### is_instanceof

Verifies that the current value is an instance of the given type.
```gd
func assert_object(<current>).is_instanceof(<expected>) -> GdUnitObjectAssert
```
```gd
# this assertion succeeds
assert_object(Path.new()).is_instanceof(Node)

# should fail because the current is not a instance of class Tree
assert_object(Path.new()).is_instanceof(Tree)
```

### is_not_instanceof

Verifies that the current value is not an instance of the given type.
```gd
func assert_object(<current>).is_not_instanceof(<expected>) -> GdUnitObjectAssert
```
```gd
# this assertion succeeds
assert_object(Path.new()).is_not_instanceof(Tree)

# should fail because Path is a instance of class Node (Path < Spatial < Node < Object)
assert_object(Path.new()).is_not_instanceof(Node)
```

### is_valid

Verifies that the current value is a valid, unfreed instance.
```gd
func assert_object(<current>).is_valid() -> GdUnitObjectAssert
```
```gd
var node := Node.new()
# this assertion succeeds
assert_object(node).is_valid()

node.free()
# should fail because the node has already been freed
assert_object(node).is_valid()
```
