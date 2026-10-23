---
layout: default
title: String Assert
parent: Asserts
---

# String Assertions

An assertion tool to verify **String** and **StringName** values.

**GdUnitStringAssert**<br>

|Function|Description|
|--- | --- |
|[is_null]({{site.baseurl}}/testing/assert-string/#is_null)| Verifies that the current value is null.|
|[is_not_null]({{site.baseurl}}/testing/assert-string/#is_not_null)| Verifies that the current value is not null.|
|[is_equal]({{site.baseurl}}/testing/assert-string/#is_equal) | Verifies that the current String is equal to the given one.|
|[is_equal_ignoring_case]({{site.baseurl}}/testing/assert-string/#is_equal_ignoring_case) | Verifies that the current String is equal to the given one, ignoring case considerations.|
|[is_not_equal]({{site.baseurl}}/testing/assert-string/#is_not_equal) | Verifies that the current String is not equal to the given one.|
|[is_not_equal_ignoring_case]({{site.baseurl}}/testing/assert-string/#is_not_equal_ignoring_case) | Verifies that the current String is not equal to the given one, ignoring case considerations.|
|[is_empty]({{site.baseurl}}/testing/assert-string/#is_empty) | Verifies that the current String is empty, it has a length of 0.|
|[is_not_empty]({{site.baseurl}}/testing/assert-string/#is_not_empty) | Verifies that the current String is not empty, it has a length of minimum 1.|
|[contains]({{site.baseurl}}/testing/assert-string/#contains) | Verifies that the current String contains the given String.|
|[contains_ignoring_case]({{site.baseurl}}/testing/assert-string/#contains_ignoring_case) | Verifies that the current String does not contain the given String, ignoring case considerations.|
|[not_contains]({{site.baseurl}}/testing/assert-string/#not_contains) | Verifies that the current String does not contain the given String.|
|[not_contains_ignoring_case]({{site.baseurl}}/testing/assert-string/#not_contains_ignoring_case) | Verifies that the current String does not contain the given String, ignoring case considerations.|
|[starts_with]({{site.baseurl}}/testing/assert-string/#starts_with) | Verifies that the current String starts with the given prefix.|
|[ends_with]({{site.baseurl}}/testing/assert-string/#ends_with) | Verifies that the current String ends with the given suffix.|
|[has_length]({{site.baseurl}}/testing/assert-string/#has_length) | Verifies that the current String has the expected length by used comparator.|

---

## String Assert Examples

### is_null

Verifies that the current value is null.
```gd
func assert_str(<current>).is_null() -> GdUnitStringAssert
```
```gd
# this assertion succeeds
assert_str(null).is_null()

# should fail because the value is not null
assert_str("a string").is_null()
```

### is_not_null

Verifies that the current value is not null.
```gd
func assert_str(<current>).is_not_null() -> GdUnitStringAssert
```
```gd
# this assertion succeeds
assert_str("a string").is_not_null()

# should fail because the value is null
assert_str(null).is_not_null()
```

### is_equal

Verifies that the current **String** or **StringName** is equal to the given one.
```gd
func assert_str(<current>).is_equal(<expected>) -> GdUnitStringAssert
```
```gd
# this assertion succeeds
assert_str("This is a test message").is_equal("This is a test message")

# this assertion fails because the 'Message' is writen camel case
assert_str("This is a test message").is_equal("This is a test Message")
```

### is_equal_ignoring_case

Verifies that the current **String** or **StringName** is equal to the given one, ignoring case considerations.
```gd
func assert_str(<current>).is_equal_ignoring_case(<expected>) -> GdUnitStringAssert
```
```gd
# this assertion succeeds
assert_str("This is a test message").is_equal_ignoring_case("This is a test Message")

# this assertion fails because 'test' is missing 
assert_str("This is a test message").is_equal_ignoring_case("This is a Message")
```

### is_not_equal

Verifies that the current **String** or **StringName** is not equal to the given one.
```gd
func assert_str(<current>).is_not_equal(<expected>) -> GdUnitStringAssert
```
```gd
# this assertion succeeds
assert_str("This is a test message").is_not_equal("This is a test Message")

# this assertion fails because the values are equal
assert_str("This is a test message").is_not_equal("This is a test message")
```

### is_not_equal_ignoring_case

Verifies that the current **String** or **StringName** is not equal to the given one, ignoring case considerations.
```gd
func assert_str(<current>).is_not_equal_ignoring_case(<expected>) -> GdUnitStringAssert
```
```gd
# this assertion succeeds
assert_str("This is a test message").is_not_equal_ignoring_case("This is a Message")

# this assertion fails because the values are equal ignoring camel case
assert_str("This is a test message").is_not_equal_ignoring_case("This is a test Message")
```

### is_empty

Verifies that the current **String** or **StringName** is empty, it has a length of 0.
```gd
func assert_str(<current>).is_empty() -> GdUnitStringAssert
```
```gd
# this assertion succeeds
assert_str("").is_empty()

# this assertion fails because the values contains a single space
assert_str(" ").is_empty()
```

### is_not_empty

Verifies that the current **String** or **StringName** is not empty, it has a length of minimum 1.
```gd
func assert_str(<current>).is_not_empty() -> GdUnitStringAssert
```
```gd
# this assertion succeeds
assert_str(" ").is_not_empty()

# this assertion fails because the values empty (has size of 0 lenght)
assert_str("").is_not_empty()
```

### contains

Verifies that the current **String** or **StringName** contains the given String.
```gd
func assert_str(<current>).contains(<expected>) -> GdUnitStringAssert
```
```gd
# this assertion succeeds
assert_str("This is a String").contains("is")

# this assertion fails
assert_str("This is a String").contains("not")
```

### contains_ignoring_case

Verifies that the current **String** or **StringName** does not contain the given String, ignoring case considerations.
```gd
func assert_str(<current>).contains_ignoring_case(<expected>) -> GdUnitStringAssert
```
```gd
# this assertion succeeds
assert_str("This is a String").contains_ignoring_case("IS")

# this assertion fails
assert_str("This is a String").contains_ignoring_case("not")
```

### not_contains

Verifies that the current **String** or **StringName** does not contain the given String.
```gd
func assert_str(<current>).not_contains(<expected>) -> GdUnitStringAssert
```
```gd
# this assertion succeeds
assert_str("This is a String").not_contains("not")

# this assertion fails
assert_str("This is a String").not_contains("is")
```

### not_contains_ignoring_case

Verifies that the current **String** or **StringName** does not contain the given String, ignoring case considerations.
```gd
func assert_str(<current>).not_contains_ignoring_case(<expected>) -> GdUnitStringAssert
```
```gd
# this assertion succeeds
assert_str("This is a String").not_contains_ignoring_case("Not")

# this assertion fails
assert_str("This is a String").not_contains_ignoring_case("IS")
```

### starts_with

Verifies that the current **String** or **StringName** starts with the given prefix.
```gd
func assert_str(<current>).starts_with(<expected>) -> GdUnitStringAssert
```
```gd
# this assertion succeeds
assert_str("This is a String").starts_with("This is")

# this assertion fails
assert_str("This is a String").starts_with("a String")
```

### ends_with

Verifies that the current **String** or **StringName** ends with the given suffix.
```gd
func assert_str(<current>).ends_with(<expected>) -> GdUnitStringAssert
```
```gd
# this assertion succeeds
assert_str("This is a String").ends_with("a String")

# this assertion fails
assert_str("This is a String").ends_with("a Str")
```

### has_length

Verifies that the current **String** or **StringName** has the expected length by used [[comparator|Asserts#gunit Comparator]].
```gd
func assert_str(<current>).has_length(<expected>, <comparator> (EXACTLY)) -> GdUnitStringAssert
```
```gd
# this assertion succeeds because the current String has 22 characters 
assert_str("This is a test message").has_length(22)
assert_str("This is a test message").has_length(23, Comparator.LESS_THAN)
assert_str("This is a test message").has_length(22, Comparator.LESS_EQUAL)
assert_str("This is a test message").has_length(21, Comparator.GREATER_THAN)
assert_str("This is a test message").has_length(21, Comparator.GREATER_EQUAL)

# this assertion fails because the current String has 22 characters and not 23
assert_str("This is a test message").has_length(23)
assert_str("This is a test message").has_length(22, Comparator.LESS_THAN)
assert_str("This is a test message").has_length(21, Comparator.LESS_EQUAL) 
assert_str("This is a test message").has_length(22, Comparator.GREATER_THAN)
assert_str("This is a test message").has_length(23, Comparator.GREATER_EQUAL)
```
