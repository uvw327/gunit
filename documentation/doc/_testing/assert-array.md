---
layout: default
title: Array Assert
parent: Asserts
---

# Array Assertions

An assertion tool to verify arrays, supports all Godot array types

**GdUnitArrayAssert**<br>

|Function|Description|
|--- | --- |
|[is_null]({{site.baseurl}}/testing/assert-array/#is_null) | Verifies that the current value is null.|
|[is_not_null]({{site.baseurl}}/testing/assert-array/#is_not_null) | Verifies that the current value is not null.|
|[is_equal]({{site.baseurl}}/testing/assert-array/#is_equal) | Verifies that the current Array is equal to the given one.|
|[is_equal_ignoring_case]({{site.baseurl}}/testing/assert-array/#is_equal_ignoring_case) | Verifies that the current Array is equal to the given one, ignoring case considerations.|
|[is_not_equal]({{site.baseurl}}/testing/assert-array/#is_not_equal) | Verifies that the current Array is not equal to the given one.|
|[is_not_equal_ignoring_case]({{site.baseurl}}/testing/assert-array/#is_not_equal_ignoring_case) | Verifies that the current Array is not equal to the given one, ignoring case considerations.|
|[is_same]({{site.baseurl}}/testing/assert-array/#is_same) | Verifies that the current Array is the same.|
|[is_not_same]({{site.baseurl}}/testing/assert-array/#is_not_same) | Verifies that the current Array is NOT the same.|
|[is_empty]({{site.baseurl}}/testing/assert-array/#is_empty) | Verifies that the current Array is empty, it has a size of 0.|
|[is_not_empty]({{site.baseurl}}/testing/assert-array/#is_not_empty) | Verifies that the current Array is not empty, it has a size of minimum 1.|
|[has_size]({{site.baseurl}}/testing/assert-array/#has_size) | Verifies that the current Array has a size of given value.|
|[contains]({{site.baseurl}}/testing/assert-array/#contains) | Verifies that the current Array contains the given values, in any order.|
|[contains_exactly]({{site.baseurl}}/testing/assert-array/#contains_exactly) | Verifies that the current Array contains exactly only the given values and nothing else, in same order.|
|[contains_exactly_in_any_order]({{site.baseurl}}/testing/assert-array/#contains_exactly_in_any_order) | Verifies that the current Array contains exactly only the given values and nothing else, in any order.|
|[not_contains]({{site.baseurl}}/testing/assert-array/#not_contains) | Verifies that the current Array do NOT contains the given values, in any order.|
|[contains_same]({{site.baseurl}}/testing/assert-array/#contains_same) | Verifies that the current Array contains the given values, in any order.|
|[contains_same_exactly]({{site.baseurl}}/testing/assert-array/#contains_same_exactly) | Verifies that the current Array contains exactly only the given values and nothing else, in same order.|
|[contains_same_exactly_in_any_order]({{site.baseurl}}/testing/assert-array/#contains_same_exactly_in_any_order) | Verifies that the current Array contains exactly only the given values and nothing else, in any order.|
|[not_contains_same]({{site.baseurl}}/testing/assert-array/#not_contains_same) | Verifies that the current Array do NOT contains the given values, in any order.|
|[extract]({{site.baseurl}}/testing/assert-array/#extract) | Extracts all values by given function name and optional arguments.|
|[extractv]({{site.baseurl}}/testing/assert-array/#extractv) | Extracts all values by given extractor's.|

---

## Array Assert Examples

### is_null

Verifies that the current value is null.
```gd
func assert_array(<current>).is_null() -> GdUnitArrayAssert
```
```gd
# this assertion succeeds
assert_array(null).is_null()

# should fail because the array not null
assert_array([]).is_null()
```

### is_not_null

Verifies that the current value is not null.
```gd
func assert_array(<current>).is_not_null() -> GdUnitArrayAssert
```
```gd
# this assertion succeeds
assert_array([]).is_not_null()

# should fail because the array is null
assert_array(null).is_not_null()
```

### is_equal

Verifies that the current Array is equal to the given one.<br>
The values are compared by deep parameter comparision, for object reference compare you have to use [is_same]({{site.baseurl}}/testing/assert-array/#is_same).<br>
For more details about comparision works see [How gunit Asserts compares Objects]({{site.baseurl}}/testing/assert/#how-gunit-asserts-compares-objects)
```gd
func assert_array(<current>).is_equal(<expected>) -> GdUnitArrayAssert
```
```gd
var a := [1, 2, 3, 4, 2, 5]
# this assertion succeeds, all values are equal
assert_array(a).is_equal(1, 2, 3, 4, 2, 5)

# should fail because the array not contains the expected elements and has diff size
assert_array(a).is_equal(1, 2, 3, 4, 2, 5, 7)
```

### is_equal_ignoring_case

Verifies that the current Array is equal to the given one, ignoring case considerations.
```gd
func assert_array(<current>).is_equal_ignoring_case(<expected>) -> GdUnitArrayAssert
```
```gd
# this assertion succeeds
assert_array(["this", "is", "a", "message"]).is_equal_ignoring_case("This", "is", "a", "Message")

# should fail because the array not contains same elements
assert_array(["this", "is", "a", "message"]).is_equal_ignoring_case("This", "is", "an", "Message")
```

### is_not_equal

Verifies that the current Array is not equal to the given one.<br>
The values are compared by deep parameter comparision, for object reference compare you have to use [is_not_same]({{site.baseurl}}/testing/assert-array/#is_not_same).<br>
For more details about comparision works see [How gunit Asserts compares Objects]({{site.baseurl}}/testing/assert/#how-gunit-asserts-compares-objects)
```gd
func assert_array(<current>).is_not_equal(<expected>) -> GdUnitArrayAssert
```
```gd
# this assertion succeeds
assert_array([1, 2, 3, 4, 5]).is_not_equal(1, 2, 3, 4, 5, 6)

# should fail because the array contains same elements
assert_array([1, 2, 3, 4, 5]).is_not_equal(1, 2, 3, 4, 5)
```

### is_not_equal_ignoring_case

Verifies that the current Array is not equal to the given one, ignoring case considerations.
```gd
func assert_array(<current>).is_not_equal_ignoring_case(<expected>) -> GdUnitArrayAssert
```
```gd
# this assertion succeeds
assert_array(["this", "is", "a", "message"]).is_not_equal_ignoring_case("This", "is", "an", "Message")

# should fail because the array contains same elements ignoring case sensitive
assert_array(["this", "is", "a", "message"]).is_not_equal_ignoring_case("This", "is", "a", "Message")
```

### is_same

Verifies that the current Array is the same.<br>
The array are compared by object reference, for deep parameter comparision use [is_equal]({{site.baseurl}}/testing/assert-array/#is_equal).<br>
For more details about comparision works see [How gunit Asserts compares Objects]({{site.baseurl}}/testing/assert/#how-gunit-asserts-compares-objects)
```gd
func assert_array(<current>).is_same(<expected>) -> GdUnitArrayAssert
```
```gd
var a := [1, 2, 3, 4, 2, 5]
var b := [1, 2, 3, 4, 2, 5]
# this assertion succeeds
assert_array(a).is_same(a)

# should fail because the arrays are not the same
assert_array(a).is_same(b)
```

### is_not_same

Verifies that the current Array is the NOT same.<br>
The array are compared by object reference, for deep parameter comparision use [is_not_equal]({{site.baseurl}}/testing/assert-array/#is_not_equal).<br>
For more details about comparision works see [How gunit Asserts compares Objects]({{site.baseurl}}/testing/assert/#how-gunit-asserts-compares-objects)
```gd
func assert_array(<current>).is_not_same(<expected>) -> GdUnitArrayAssert
```
```gd
var a := [1, 2, 3, 4, 2, 5]
var b := [1, 2, 3, 4, 2, 5]
# this assertion succeeds
assert_array(a).is_not_same(b)

# should fail because the arrays are the same
assert_array(a).is_not_same(a)
```

### is_empty

Verifies that the current Array is empty, it has a size of 0.
```gd
func assert_array(<current>).is_empty() -> GdUnitArrayAssert
```
```gd
# this assertion succeeds
assert_array([]).is_empty()

# should fail because the array is not empty it has a size of one
assert_array([1]).is_empty()
```

### is_not_empty

Verifies that the current Array is not empty, it has a size of minimum 1.
```gd
func assert_array(<current>).is_not_empty() -> GdUnitArrayAssert
```
```gd
# this assertion succeeds
assert_array([1]).is_not_empty()

# should fail because the array is empty
assert_array([]).is_not_empty()
```

### has_size

Verifies that the current Array has a size of given value.
```gd
func assert_array(<current>).has_size(<expected>) -> GdUnitArrayAssert
```
```gd
# this assertion succeeds
assert_array([1, 2, 3, 4, 5]).has_size(5)
assert_array(["a", "b", "c", "d", "e", "f"]).has_size(6)

# should fail because the array has a size of 5 and not 4
assert_array([1, 2, 3, 4, 5]).has_size(4)
```

### contains

Verifies that the current Array contains the given values, in any order.<br>
The values are compared by deep parameter comparision, for object reference compare you have to use [contains_same]({{site.baseurl}}/testing/assert-array/#contains_same).<br>
For more details about comparision works see [How gunit Asserts compares Objects]({{site.baseurl}}/testing/assert/#how-gunit-asserts-compares-objects)
```gd
func assert_array(<current>).contains(<expected>) -> GdUnitArrayAssert
```
```gd
# this assertion succeeds
assert_array([1, 2, 3, 4, 5]).contains(5, 2)

# should fail because the array not contains 7 and 6
assert_array([1, 2, 3, 4, 5]).contains(2, 7, 6)
```

### contains_exactly

Verifies that the current Array contains exactly only the given values and nothing else, in same order.<br>
The values are compared by deep parameter comparision, for object reference compare you have to use [contains_same_exactly]({{site.baseurl}}/testing/assert-array/#contains_same_exactly).<br>
For more details about comparision works see [How gunit Asserts compares Objects]({{site.baseurl}}/testing/assert/#how-gunit-asserts-compares-objects)
```gd
func assert_array(<current>).contains_exactly(<expected>) -> GdUnitArrayAssert
```
```gd
# this assertion succeeds
assert_array([1, 2, 3, 4, 5]).contains_exactly(1, 2, 3, 4, 5)

# should fail because the array contains the same elements but in a different order
assert_array([1, 2, 3, 4, 5]).contains_exactly(1, 4, 3, 2, 5)
```

### contains_exactly_in_any_order

Verifies that the current Array contains exactly only the given values and nothing else, in any order.<br>
The values are compared by deep parameter comparision, for object reference compare you have to use [contains_same_exactly_in_any_order]({{site.baseurl}}/testing/assert-array/#contains_same_exactly_in_any_order).<br>
For more details about comparision works see [How gunit Asserts compares Objects]({{site.baseurl}}/testing/assert/#how-gunit-asserts-compares-objects)
```gd
func contains_exactly_in_any_order(expected) -> GdUnitArrayAssert:
```
```gd
# this assertion succeeds, contains all elements but in a different order
assert_array([1, 2, 3, 4, 5]).contains_exactly_in_any_order(1, 5, 3, 4, 2)

# should fail because the array contains not exacly all elements (5 is missing)
assert_array([1, 2, 3, 4]).contains_exactly(1, 4, 3, 2)
```

### not_contains

Verifies that the current Array do NOT contains the given values, in any order.<br>
The values are compared by deep parameter comparision, for object reference compare you have to use [not_contains_same]({{site.baseurl}}/testing/assert-array/#not_contains_same).<br>
For more details about comparision works see [How gunit Asserts compares Objects]({{site.baseurl}}/testing/assert/#how-gunit-asserts-compares-objects)
```gd
func not_contains(expected) -> GdUnitArrayAssert:
```
```gd
# this assertion succeeds
assert_array([1, 2, 3, 4, 5]).not_contains(6, 0)

# should fail because the array contains the value 2
assert_array([1, 2, 3, 4]).contains_exactly(6, 0, 2)
```

### contains_same

Verifies that the current Array contains the same values, in any order.<br>
The values are compared by object reference, for deep parameter comparision use [contains]({{site.baseurl}}/testing/assert-array/#contains).<br>
For more details about comparision works see [How gunit Asserts compares Objects]({{site.baseurl}}/testing/assert/#how-gunit-asserts-compares-objects)
```gd
func assert_array(<current>).contains_same(<expected>) -> GdUnitArrayAssert
```
```gd
var value_a := Node.new()
var value_b := Node.new()
var value_c := Node.new()
var a := [value_a, value_b]

# this assertion succeeds
assert_array(a).contains_same(value_a)

# should fail because the array not contains value_c
assert_array(a).contains_same(value_c)
```

### contains_same_exactly

Verifies that the current Array contains exactly only the given values and nothing else, in same order.<br>
The values are compared by object reference, for deep parameter comparision use [contains_exactly]({{site.baseurl}}/testing/assert-array/#contains_exactly).<br>
For more details about comparision works see [How gunit Asserts compares Objects]({{site.baseurl}}/testing/assert/#how-gunit-asserts-compares-objects)
```gd
func assert_array(<current>).contains_same_exactly(<expected>) -> GdUnitArrayAssert
```
```gd
var value_a := Node.new()
var value_b := Node.new()
var a := [value_a, value_b]

# this assertion succeeds
assert_array(a).contains_same_exactly(value_a, value_b)

# should fail because the array not contains more than value_a
assert_array(a).contains_same_exactly(value_a)
```

### contains_same_exactly_in_any_order

Verifies that the current Array contains exactly only the given values and nothing else, in any order.<br>
The values are compared by object reference, for deep parameter comparision use [contains_exactly_in_any_order]({{site.baseurl}}/testing/assert-array/#contains_exactly_in_any_order).<br>
For more details about comparision works see [How gunit Asserts compares Objects]({{site.baseurl}}/testing/assert/#how-gunit-asserts-compares-objects)
```gd
func assert_array(<current>).contains_same_exactly_in_any_order(<expected>) -> GdUnitArrayAssert
```
```gd
var value_a := Node.new()
var value_b := Node.new()
var a := [value_a, value_b]

# this assertion succeeds
assert_array(a).contains_same_exactly_in_any_order(value_b, value_a)

# should fail because the array not contains more than value_a
assert_array(a).contains_same_exactly_in_any_order(value_a)
```

### not_contains_same

Verifies that the current Array do NOT contains the same values, in any order.<br>
The values are compared by object reference, for deep parameter comparision use [not_contains]({{site.baseurl}}/testing/assert-array/#not_contains).<br>
For more details about comparision works see [How gunit Asserts compares Objects]({{site.baseurl}}/testing/assert/#how-gunit-asserts-compares-objects)
```gd
func not_contains_same(expected) -> GdUnitArrayAssert:
```
```gd
# this assertion succeeds
assert_array([1, 2, 3, 4, 5]).not_contains_same(6, 0)

# should fail because the array contains the value 2
assert_array([1, 2, 3, 4]).not_contains_same([6, 0, 2)
```

### extract

Extracts all values by given function name and optional arguments into a new ArrayAssert.
If the elements not accessible by `func_name` the value is converted to `"n.a"`, expecting null values

You can use function name chaining e.g. `get_parent.get_name`
```gd
func assert_array(<current>).extract(<func_name :String>, [args :Array]) -> GdUnitArrayAssert
func assert_array(<current>).extract(<func_name :String>[.<func_name>, ..]) -> GdUnitArrayAssert
```
```gd
# extracting only by function name "get_class"
assert_array([Reference.new(), 2, AStar.new(), auto_free(Node.new())])\
    .extract("get_class")\
    .contains_exactly(["Reference", "n.a.", "AStar", "Node"])
# extracting by a function name and arguments
assert_array([Reference.new(), 2, AStar.new(), auto_free(Node.new())])\
    .extract("has_signal", ["tree_entered"])\
    .contains_exactly([false, "n.a.", false, true])
```

### extractv

Extracts all values by given extractor's into a new ArrayAssert, a maximum of teen extractors currently supported.
If the elements not extractable than the value is converted to `"n.a"`, expecting null values

To check multiple extracted values you must use `tuple`, which accepts any number of values (since v6.1 truly variadic, no longer limited to ten).
For programmatic or data-driven usage you can also construct a tuple from an existing array with `GdUnitTuple.of(array)`.
```gd
func assert_array(<current>).extractv(<extractor:GdUnitValueExtractor>[, extractor, ..]) -> GdUnitArrayAssert
```
```gd
# example object for extraction
class TestObj:
    var _name :String
    var _value
    var _x

    func _init(name :String, value, x = null):
        _name = name
        _value = value
        _x = x

    func get_name() -> String:
        return _name

    func get_value():
        return _value

    func get_x():
        return _x
```
```gd
# single extract
assert_array([1, false, 3.14, null, Color.aliceblue])\
    .extractv(extr("get_class"))\
    .contains_exactly(["n.a.", "n.a.", "n.a.", null, "n.a."])
# tuple of two
assert_array([TestObj.new("A", 10), TestObj.new("B", "foo"), Color.aliceblue, TestObj.new("C", 11)])\
    .extractv(extr("get_name"), extr("get_value"))\
    .contains_exactly([
        tuple("A", 10),
        tuple("B", "foo"),
        tuple("n.a.", "n.a."), 
        tuple("C", 11)])
# tuple of three
assert_array([TestObj.new("A", 10), TestObj.new("B", "foo", "bar"), TestObj.new("C", 11, 42)])\
    .extractv(extr("get_name"), extr("get_value"), extr("get_x"))\
    .contains_exactly([
        tuple("A", 10, null),
        tuple("B", "foo", "bar"), 
        tuple("C", 11, 42)])
```

### custom value extractor

gunit provides `extr` function to build a value extractor by given function name and optional arguments.
You can use also function name chaining e.g. `get_parent.get_name`

```gd
# Builds an extractor by given function name and optional arguments
static func extr(<func_name :String>[.func_name, ..], [args :Array]) -> GdUnitValueExtractor:
```
