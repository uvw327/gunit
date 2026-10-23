---
layout: default
title: Integer Assert
parent: Asserts
---

# Integer Assertions

An assertion tool to verify integer values.

**GdUnitIntAssert**<br>

|Function|Description|
|--- | --- |
|[is_null]({{site.baseurl}}/testing/assert-integer/#is_null) | Verifies that the current value is null.|
|[is_not_null]({{site.baseurl}}/testing/assert-integer/#is_not_null) | Verifies that the current value is not null.|
|[is_equal]({{site.baseurl}}/testing/assert-integer/#is_equal) | Verifies that the current value is equal to the given one.|
|[is_not_equal]({{site.baseurl}}/testing/assert-integer/#is_not_equal) | Verifies that the current value is not equal to the given one.|
|[is_less]({{site.baseurl}}/testing/assert-integer/#is_less) | Verifies that the current value is less than the given one.|
|[is_less_equal]({{site.baseurl}}/testing/assert-integer/#is_less_equal) | Verifies that the current value is less than or equal the given one.|
|[is_greater]({{site.baseurl}}/testing/assert-integer/#is_greater) | Verifies that the current value is greater than the given one.|
|[is_greater_equal]({{site.baseurl}}/testing/assert-integer/#is_greater_equal) | Verifies that the current value is greater than or equal the given one.|
|[is_even]({{site.baseurl}}/testing/assert-integer/#is_even) | Verifies that the current value is even.|
|[is_odd]({{site.baseurl}}/testing/assert-integer/#is_odd) | Verifies that the current value is odd.|
|[is_negative]({{site.baseurl}}/testing/assert-integer/#is_negative) | Verifies that the current value is negative.|
|[is_not_negative]({{site.baseurl}}/testing/assert-integer/#is_not_negative) | Verifies that the current value is not negative.|
|[is_zero]({{site.baseurl}}/testing/assert-integer/#is_zero) | Verifies that the current value is equal to zero.|
|[is_not_zero]({{site.baseurl}}/testing/assert-integer/#is_not_zero) | Verifies that the current value is not equal to zero.|
|[is_in]({{site.baseurl}}/testing/assert-integer/#is_in) | Verifies that the current value is in the given set of values.|
|[is_not_in]({{site.baseurl}}/testing/assert-integer/#is_not_in) | Verifies that the current value is not in the given set of values.|
|[is_between]({{site.baseurl}}/testing/assert-integer/#is_between) | Verifies that the current value is between the given boundaries (inclusive).|

---

## Integer Assert Examples

### is_null

Verifies that the current value is null.
```gd
func assert_int(<current>).is_null() -> GdUnitIntAssert
```
```gd
# this assertion succeeds
assert_int(null).is_null()

# should fail because the value is not null
assert_int(23).is_null()
```

### is_not_null

Verifies that the current value is not null.
```gd
func assert_int(<current>).is_not_null() -> GdUnitIntAssert
```
```gd
# this assertion succeeds
assert_int(23).is_not_null()

# should fail because the value is null
assert_int(null).is_not_null()
```

### is_equal

Verifies that the current value is equal to the given one.
```gd
func assert_int(<current>).is_equal(<expected>) -> GdUnitIntAssert
```
```gd
# this assertion succeeds
assert_int(23).is_equal(23)

# this assertion fails because 23 are not equal to 42
assert_int(23).is_equal(42)
```

### is_not_equal

Verifies that the current value is not equal to the given one.
```gd
func assert_int(<current>).is_not_equal(<expected>) -> GdUnitIntAssert
```
```gd
# this assertion succeeds
assert_int(23).is_not_equal(42)

# this assertion fails because 23 are equal to 23 
assert_int(23).is_not_equal(23)
```

### is_less

Verifies that the current value is less than the given one.
```gd
func assert_int(<current>).is_less(<expected>) -> GdUnitIntAssert
```
```gd
# this assertion succeeds
assert_int(23).is_less(42)
assert_int(23).is_less(24)

# this assertion fails because 23 is not less than 23
assert_int(23).is_less(23)
```

### is_less_equal

Verifies that the current value is less than or equal the given one.
```gd
func assert_int(<current>).is_less_equal(<expected>) -> GdUnitIntAssert
```
```gd
# this assertion succeeds
assert_int(23).is_less_equal(42)
assert_int(23).is_less_equal(23)

# this assertion fails because 23 is not less than or equal to 22
assert_int(23).is_less_equal(22)
```

### is_greater

Verifies that the current value is greater than the given one.
```gd
func assert_int(<current>).is_greater(<expected>) -> GdUnitIntAssert
```
```gd
# this assertion succeeds
assert_int(23).is_greater(20)
assert_int(23).is_greater(22)

# this assertion fails because 23 is not greater than 23
assert_int(23).is_greater(23)
```

### is_greater_equal

Verifies that the current value is greater than or equal the given one.
```gd
func assert_int(<current>).is_greater_equal(<expected>) -> GdUnitIntAssert
```
```gd
assert_int(23).is_greater_equal(20)
assert_int(23).is_greater_equal(23)

# this assertion fails because 23 is not greater than 23
assert_int(23).is_greater_equal(24)
```

### is_even

Verifies that the current value is even.
```gd
func assert_int(<current>).is_even() -> GdUnitIntAssert
```
```gd
# this assertion succeeds
assert_int(12).is_even()

# this assertion fail because the value '13' is not even
assert_int(13).is_even()
```

### is_odd

Verifies that the current value is odd.
```gd
func assert_int(<current>).is_odd() -> GdUnitIntAssert
```
```gd
# this assertion succeeds
assert_int(13).is_odd()

# this assertion fail because the value '12' is even
assert_int(12).is_odd()
```

### is_negative

Verifies that the current value is negative.
```gd
func assert_int(<current>).is_negative() -> GdUnitIntAssert
```
```gd
# this assertion succeeds
assert_int(-13).is_negative()

# this assertion fail because the value '13' is positive
assert_int(13).is_negative()
```

### is_not_negative

Verifies that the current value is not negative.
```gd
func assert_int(<current>).is_not_negative() -> GdUnitIntAssert
```
```gd
# this assertion succeeds
assert_int(13).is_not_negative()

# this assertion fail because the value '-13' is negative
assert_int(-13).is_not_negative()
```

### is_zero

Verifies that the current value is equal to zero.
```gd
func assert_int(<current>).is_zero() -> GdUnitIntAssert
```
```gd
# this assertion succeeds
assert_int(0).is_zero()

# this assertion fail because the value is not zero
assert_int(1).is_zero()
```

### is_not_zero

Verifies that the current value is not equal to zero.
```gd
func assert_int(<current>).is_not_zero() -> GdUnitIntAssert
```
```gd
# this assertion succeeds
assert_int(1).is_not_zero()

# this assertion fail because the value is zero
assert_int(0).is_not_zero()
```

### is_in

Verifies that the current value is in the given set of values.
```gd
func assert_int(<current>).is_in(<expected> :Array) -> GdUnitIntAssert
```
```gd
# this assertion succeeds
assert_int(5).is_in([3, 4, 5, 6])

# this assertion fail because 7 is not in [3, 4, 5, 6]
assert_int(7).is_in([3, 4, 5, 6])
```

### is_not_in

Verifies that the current value is not in the given set of values.
```gd
func assert_int(<current>).is_not_in(<expected> :Array) -> GdUnitIntAssert
```
```gd
# this assertion succeeds
assert_int(5).is_not_in([3, 4, 6, 7])

# this assertion fail because 5 is in [3, 4, 5, 6]
assert_int(5).is_not_in([3, 4, 5, 6])
```

### is_between

Verifies that the current value is between the given boundaries (inclusive).
```gd
func assert_int(<current>).is_between(<from>, <to>) -> GdUnitIntAssert
```
```gd
# this assertion succeeds
assert_int(23).is_between(20, 30)
assert_int(23).is_between(23, 24)

# this assertion fail because the value is zero and not between 1 and 9
assert_int(0).is_between(1, 9)
```
