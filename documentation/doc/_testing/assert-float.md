---
layout: default
title: Float/Double Assert
parent: Asserts
---

# Float/Double Assertions

An assertion tool to verify float values.

**GdUnitFloatAssert**<br>

|Function|Description|
|--- | --- |
|[is_null]({{site.baseurl}}/testing/assert-float/#is_null) | Verifies that the current value is null.|
|[is_not_null]({{site.baseurl}}/testing/assert-float/#is_not_null) | Verifies that the current value is not null.|
|[is_equal]({{site.baseurl}}/testing/assert-float/#is_equal) | Verifies that the current value is equal to the given one.|
|[is_not_equal]({{site.baseurl}}/testing/assert-float/#is_not_equal) | Verifies that the current value is not equal to the given one.|
|[is_equal_approx]({{site.baseurl}}/testing/assert-float/#is_equal_approx) | Verifies that the current and expected value are approximately equal.|
|[is_less]({{site.baseurl}}/testing/assert-float/#is_less) | Verifies that the current value is less than the given one.|
|[is_less_equal]({{site.baseurl}}/testing/assert-float/#is_less_equal) | Verifies that the current value is less than or equal the given one.|
|[is_greater]({{site.baseurl}}/testing/assert-float/#is_greater) | Verifies that the current value is greater than the given one.|
|[is_greater_equal]({{site.baseurl}}/testing/assert-float/#is_greater_equal) | Verifies that the current value is greater than or equal the given one.|
|[is_negative]({{site.baseurl}}/testing/assert-float/#is_negative) | Verifies that the current value is negative.|
|[is_not_negative]({{site.baseurl}}/testing/assert-float/#is_not_negative) | Verifies that the current value is not negative.|
|[is_zero]({{site.baseurl}}/testing/assert-float/#is_zero) | Verifies that the current value is equal to zero.|
|[is_not_zero]({{site.baseurl}}/testing/assert-float/#is_not_zero) | Verifies that the current value is not equal to zero.|
|[is_in]({{site.baseurl}}/testing/assert-float/#is_in) | Verifies that the current value is in the given set of values.|
|[is_not_in]({{site.baseurl}}/testing/assert-float/#is_not_in) | Verifies that the current value is not in the given set of values.|
|[is_between]({{site.baseurl}}/testing/assert-float/#is_between) | Verifies that the current value is between the given boundaries (inclusive).|

---

## Float Assert Examples

### is_null

Verifies that the current value is null.
```gd
func assert_float(<current>).is_null() -> GdUnitFloatAssert
```
```gd
# this assertion succeeds
assert_float(null).is_null()

# should fail because the value is not null
assert_float(3.0).is_null()
```

### is_not_null

Verifies that the current value is not null.
```gd
func assert_float(<current>).is_not_null() -> GdUnitFloatAssert
```
```gd
# this assertion succeeds
assert_float(3.0).is_not_null()

# should fail because the value is null
assert_float(null).is_not_null()
```

### is_equal

Verifies that the current value is equal to the given one.
```gd
func assert_float(<current>).is_equal(<expected>) -> GdUnitFloatAssert
```
```gd
# this assertion succeeds
assert_float(23.2).is_equal(23.2)

# this assertion fails because 23.2 are not equal to 23.4
assert_float(23.2).is_equal(23.4)
```

### is_not_equal

Verifies that the current value is not equal to the given one.
```gd
func assert_float(<current>).is_not_equal(<expected>) -> GdUnitFloatAssert
```
```gd
# this assertion succeeds
assert_float(23.2).is_not_equal(23.4)

# this assertion fails because 23.2 are equal to 23.2
assert_float(23.2).is_not_equal(23.2)
```

### is_equal_approx

Verifies that the current and expected value are approximately equal.
```gd
func is_equal_approx(<expected>, <approx>) -> GdUnitFloatAssert:
```
```gd
# this assertion succeeds
assert_float(23.19).is_equal_approx(23.2, 0.01)
assert_float(23.20).is_equal_approx(23.2, 0.01)
assert_float(23.21).is_equal_approx(23.2, 0.01)

# this assertion fails because 23.18 and 23.22 are not equal approximately to 23.2 +/- 0.01
assert_float(23.18).is_equal_approx(23.2, 0.01)
assert_float(23.22).is_equal_approx(23.2, 0.01)
```

### is_less

Verifies that the current value is less than the given one.
```gd
func assert_float(<current>).is_less(<expected>) -> GdUnitFloatAssert
```
```gd
# this assertion succeeds
assert_float(23.2).is_less(23.4)
assert_float(23.2).is_less(26.0)

# this assertion fails because 23.2 is not less than 23.2
assert_float(23.2).is_less(23.2)
```

### is_less_equal

Verifies that the current value is less than or equal the given one.
```gd
func assert_float(<current>).is_less_equal(<expected>) -> GdUnitFloatAssert
```
```gd
# this assertion succeeds
assert_float(23.2).is_less_equal(23.4)
assert_float(23.2).is_less_equal(23.2)

# this assertion fails because 23.2 is not less than or equal to 23.1
assert_float(23.2).is_less_equal(23.1)
```

### is_greater

Verifies that the current value is greater than the given one.
```gd
func assert_float(<current>).is_greater(<expected>) -> GdUnitFloatAssert
```
```gd
# this assertion succeeds
assert_float(23.2).is_greater(23.0)
assert_float(23.4).is_greater(22.1)

# this assertion fails because 23.2 is not greater than 23.2
assert_float(23.2).is_greater(23.2)
```

### is_greater_equal

Verifies that the current value is greater than or equal the given one.
```gd
func assert_float(<current>).is_greater_equal(<expected>) -> GdUnitFloatAssert
```
```gd
# this assertion succeeds
assert_float(23.2).is_greater_equal(20.2)
assert_float(23.2).is_greater_equal(23.2)

# this assertion fails because 23.2 is not greater than 23.3
assert_float(23.2).is_greater_equal(23.3)
```

### is_negative

Verifies that the current value is negative.
```gd
func assert_float(<current>).is_negative() -> GdUnitFloatAssert
```
```gd
# this assertion succeeds
assert_float(-13.2).is_negative()

# this assertion fails because is not negative
assert_float(13.2).is_negative()
```

### is_not_negative

Verifies that the current value is not negative.
```gd
func assert_float(<current>).is_not_negative() -> GdUnitFloatAssert
```
```gd
# this assertion succeeds
assert_float(13.2).is_not_negative()

# this assertion fails because is negative
assert_float(-13.2).is_not_negative()
```

### is_zero

Verifies that the current value is equal to zero.
```gd
func assert_float(<current>).is_zero() -> GdUnitFloatAssert
```
```gd
# this assertion succeeds
assert_float(0.0).is_zero()

# this assertion fail because the value is not zero
assert_float(0.00001).is_zero()
```

### is_not_zero

Verifies that the current value is not equal to zero.
```gd
func assert_float(<current>).is_not_zero() -> GdUnitFloatAssert
```
```gd
# this assertion succeeds
assert_float(0.00001).is_not_zero()

# this assertion fail because the value is not zero
assert_float(0.000001).is_not_zero()
```

### is_in

Verifies that the current value is in the given set of values.
```gd
func assert_float(<current>).is_in(<expected> :Array) -> GdUnitFloatAssert
```
```gd
# this assertion succeeds
assert_float(5.2).is_in([5.1, 5.2, 5.3, 5.4])

# this assertion fail because 5.5 is not in [5.1, 5.2, 5.3, 5.4]
assert_float(5.5).is_in([5.1, 5.2, 5.3, 5.4])
```

### is_not_in

Verifies that the current value is not in the given set of values.
```gd
func assert_float(<current>).is_not_in(<expected> :Array) -> GdUnitFloatAssert
```
```gd
# this assertion succeeds
assert_float(5.2).is_not_in([5.1, 5.3, 5.4])

# this assertion fail because 5.2 is not in [5.1, 5.2, 5.3, 5.4]
assert_float(5.2).is_not_in([5.1, 5.2, 5.3, 5.4])
```

### is_between

Verifies that the current value is between the given boundaries (inclusive).
```gd
func assert_float(<current>).is_between(<from>, <to>) -> GdUnitFloatAssert
```
```gd
# this assertion succeeds
assert_float(-20.0).is_between(-20.0, 20.9)
assert_float(10.0).is_between(-20.0, 20.9)
assert_float(20.9).is_between(-20.0, 20.9)

# this assertion fail because the value is -10.0 and not between -9 and 0
assert_float(-10.0).is_between(-9.0, 0.0)
```
