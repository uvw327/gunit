---
layout: default
title: Boolean Assert
parent: Asserts
---

# Boolean Assertions

An assertion tool to verify boolean values.

**GdUnitBoolAssert**<br>

|Function|Description|
|--- | --- |
|[is_true]({{site.baseurl}}/testing/assert-bool/#is_true)| Verifies that the current value is true.|
|[is_false]({{site.baseurl}}/testing/assert-bool/#is_false)| Verifies that the current value is false.|
|[is_equal]({{site.baseurl}}/testing/assert-bool/#is_equal)| Verifies that the current value is equal to the given one.|
|[is_not_equal]({{site.baseurl}}/testing/assert-bool/#is_not_equal)| Verifies that the current value is not equal to the given one.|

---

## Boolean Assert Examples

### is_true

Verifies that the current value is true.

```gd
func assert_bool(<current>).is_true() -> GdUnitBoolAssert
```
```gd
# this assertion succeeds
assert_bool(true).is_true()

# this assertion fails because the value is false and not true
assert_bool(false).is_true()
```

### is_false

Verifies that the current value is false.
```gd
func assert_bool(<current>).is_false() -> GdUnitBoolAssert
```
```gd
# this assertion succeeds
assert_bool(false).is_false()

# this assertion fails because the value is true and not false
assert_bool(true).is_false()
```

### is_equal

Verifies that the current value is equal to the given one.
```gd
func assert_bool(<current>).is_equal(<expected>) -> GdUnitBoolAssert
```
```gd
# this assertion succeeds
assert_bool(false).is_equal(false)

# this assertion fails because the value is false and not true
assert_bool(false).is_equal(true)
```

### is_not_equal

Verifies that the current value is not equal to the given one.
```gd
func assert_bool(<current>).is_not_equal(<expected>) -> GdUnitBoolAssert
```
```gd
# this assertion succeeds
assert_bool(false).is_not_equal(true)

# this assertion fails because the value is false and should not be false
assert_bool(false).is_not_equal(false)
```
