---
layout: default
title: Vector Assert
parent: Asserts
---

# Vector Assertions

An assertion tool to verify Vector values, supports all Godot Vector types.

**GdUnitVectorAssert**<br>

|Function|Description|
|--- | --- |
|[is_null]({{site.baseurl}}/testing/assert-vector/#is_null) | Verifies that the current value is null.|
|[is_not_null]({{site.baseurl}}/testing/assert-vector/#is_not_null) | Verifies that the current value is not null.|
|[is_equal]({{site.baseurl}}/testing/assert-vector/#is_equal) | Verifies that the current value is equal to the given one.|
|[is_not_equal]({{site.baseurl}}/testing/assert-vector/#is_not_equal) | Verifies that the current value is not equal to the given one.|
|[is_equal_approx]({{site.baseurl}}/testing/assert-vector/#is_equal_approx) | Verifies that the current and expected value are approximately equal.|
|[is_less]({{site.baseurl}}/testing/assert-vector/#is_less) | Verifies that the current value is less than the given one.|
|[is_less_equal]({{site.baseurl}}/testing/assert-vector/#is_less_equal) | Verifies that the current value is less than or equal the given one.|
|[is_greater]({{site.baseurl}}/testing/assert-vector/#is_greater) | Verifies that the current value is greater than the given one.|
|[is_greater_equal]({{site.baseurl}}/testing/assert-vector/#is_greater_equal) | Verifies that the current value is greater than or equal the given one.|
|[is_between]({{site.baseurl}}/testing/assert-vector/#is_between) | Verifies that the current value is between the given boundaries (inclusive).|
|[is_not_between]({{site.baseurl}}/testing/assert-vector/#is_not_between) | Verifies that the current value is not between the given boundaries (inclusive).|

---

## Vector Assert Examples

### is_null

Verifies that the current value is null.
```gd
func assert_vector(<current>).is_null() -> GdUnitVectorAssert
```
```gd
# this assertion succeeds
assert_vector(null).is_null()

# should fail because the value is not null
assert_vector(Vector2(1.1, 1.2)).is_null()
```

### is_not_null

Verifies that the current value is not null.
```gd
func assert_vector(<current>).is_not_null() -> GdUnitVectorAssert
```
```gd
# this assertion succeeds
assert_vector(Vector2(1.1, 1.2)).is_not_null()

# should fail because the value is null
assert_vector(null).is_not_null()
```

### is_equal

Verifies that the current value is equal to the given one.
```gd
func assert_vector(<current>).is_equal(<expected>) -> GdUnitVectorAssert
```
```gd
# this assertion succeeds
assert_vector(Vector2(1.1, 1.2)).is_equal(Vector2(1.1, 1.2))

# this assertion fails because part y of the vector 1.2 are not equal to 1.3
assert_vector(Vector2(1.1, 1.2)).is_equal(Vector2(1.1, 1.3))
```

### is_not_equal

Verifies that the current value is not equal to the given one.
```gd
func assert_vector(<current>).is_not_equal(<expected>) -> GdUnitVectorAssert
```
```gd
# this assertion succeeds
assert_vector(Vector2(1.1, 1.2)).is_not_equal(Vector2(1.1, 1.3))

# this assertion fails because both vectors are equal
assert_vector(Vector2(1.1, 1.2)).is_not_equal(Vector2(1.1, 1.2))
```

### is_equal_approx

Verifies that the current and expected value are approximately equal.
```gd
func assert_vector(<current>).is_equal_approx(expected, approx) -> GdUnitVectorAssert
```
```gd
# this assertion succeeds
assert_vector(Vector2(0.996, 0.996)).is_equal_approx(Vector2.ONE, Vector2(0.004, 0.004))

# this will fail because the vector is out of approximated range
assert_vector(Vector2(1.005, 1)).is_equal_approx(Vector2.ONE, Vector2(0.004, 0.004))
```

### is_less

Verifies that the current value is less than the given one.
```gd
func assert_vector(<current>).is_less(<expected>) -> GdUnitVectorAssert
```
```gd
# this assertion succeeds
assert_vector(Vector2.ZERO.is_less(Vector2.ONE)
assert_vector(Vector2(1.1, 1.2)).is_less(Vector2(1.1, 1.3))

# this assertion fails because both vectors are equal
assert_vector(Vector2(1.1, 1.2)).is_less(Vector2(1.1, 1.2))
```

### is_less_equal

Verifies that the current value is less than or equal the given one.
```gd
func assert_vector(<current>).is_less_equal(<expected>) -> GdUnitVectorAssert
```
```gd
# this assertion succeeds
assert_vector(Vector2(1.1, 1.2)).is_less_equal(Vector2(1.1, 1.3))
assert_vector(Vector2(1.1, 1.2)).is_less_equal(Vector2(1.1, 1.2))

# this assertion fails because part y 1.3 is not less or equal to 1.2 
assert_vector(Vector2(1.1, 1.3)).is_less_equal(Vector2(1.1, 1.2))
```

### is_greater

Verifies that the current value is greater than the given one.
```gd
func assert_vector(<current>).is_greater(<expected>) -> GdUnitVectorAssert
```
```gd
# this assertion succeeds
assert_vector(Vector2(1.1, 1.3)).is_greater(Vector2(1.1, 1.2))

# this assertion fails because both vectors are equal
assert_vector(Vector2(1.1, 1.2)).is_greater(Vector2(1.1, 1.2))
```

### is_greater_equal

Verifies that the current value is greater than or equal the given one.
```gd
func assert_vector(<current>).is_greater_equal(<expected>) -> GdUnitVectorAssert
```
```gd
# this assertion succeeds
assert_vector(Vector2(1.1, 1.3)).is_greater_equal(Vector2(1.1, 1.2))
assert_vector(Vector2(1.1, 1.2)).is_greater_equal(Vector2(1.1, 1.2))

# this assertion fails because part y1.2 is less than 1.3
assert_vector(Vector2(1.1, 1.2)).is_greater_equal(Vector2(1.1, 1.3))
```

### is_between

Verifies that the current value is between the given boundaries (inclusive).
```gd
func assert_vector(<current>).is_between(<from>, <to>) -> GdUnitVectorAssert
```
```gd
# this assertion succeeds
assert_vector(Vector2(1.1, 1.2)).is_between(Vector2(1.1, 1.2), Vector2(1.1, 1.3))
assert_vector(Vector2(1.1, 1.2)).is_between(Vector2(1.1, 1.1), Vector2(1.1, 1.3))

# this assertion fail because the part y 1.2 is not between 1.0 and 1.1
assert_vector(Vector2(1.1, 1.2)).is_between (Vector2(1.1, 1.0), Vector2(1.1, 1.1))
```

### is_not_between

Verifies that the current value is not between the given boundaries (inclusive).
```gd
func assert_vector(<current>).is_not_between(<from>, <to>) -> GdUnitVectorAssert
```
```gd
# this assertion succeeds
assert_vector(Vector2(1.0, 1.0)).is_not_between(Vector2(1.1, 1.0), Vector2(2.0, 1.0))

# this assertion fail because the vector is between
assert_vector(Vector2(1.0, 1.0)).is_not_between(Vector2(1.0, 1.0), Vector2(2.0, 1.0))
```
