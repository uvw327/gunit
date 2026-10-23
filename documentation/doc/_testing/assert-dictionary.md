---
layout: default
title: Dictionary Assert
parent: Asserts
---

# Dictionary Assertions

An assertion tool to verify dictionaries.

**GdUnitDictionaryAssert**<br>

|Function|Description|
|--- | --- |
|[is_null]({{site.baseurl}}/testing/assert-dictionary/#is_null) | Verifies that the current value is null.|
|[is_not_null]({{site.baseurl}}/testing/assert-dictionary/#is_not_null) | Verifies that the current value is not null.|
|[is_equal]({{site.baseurl}}/testing/assert-dictionary/#is_equal) | Verifies that the current dictionary is equal to the given one, ignoring order.|
|[is_not_equal]({{site.baseurl}}/testing/assert-dictionary/#is_not_equal) | Verifies that the current dictionary is not equal to the given one, ignoring order.|
|[is_same]({{site.baseurl}}/testing/assert-dictionary/#is_same) | Verifies that the current dictionary is the same.|
|[is_not_same]({{site.baseurl}}/testing/assert-dictionary/#is_not_same) | Verifies that the current dictionary is NOT the same.|
|[is_empty]({{site.baseurl}}/testing/assert-dictionary/#is_empty) | Verifies that the current dictionary is empty, it has a size of 0.|
|[is_not_empty]({{site.baseurl}}/testing/assert-dictionary/#is_not_empty) | Verifies that the current dictionary is not empty, it has a size of minimum 1.|
|[has_size]({{site.baseurl}}/testing/assert-dictionary/#has_size) | Verifies that the current dictionary has a size of given value.|
|[contains_keys]({{site.baseurl}}/testing/assert-dictionary/#contains_keys) | Verifies that the current dictionary contains the given keys.|
|[contains_key_value]({{site.baseurl}}/testing/assert-dictionary/#contains_key_value) | Verifies that the current dictionary contains the given key and value.|
|[not_contains_keys]({{site.baseurl}}/testing/assert-dictionary/#not_contains_keys) | Verifies that the current dictionary not contains the given keys.|
|[contains_same_keys]({{site.baseurl}}/testing/assert-dictionary/#contains_same_keys) | Verifies that the current dictionary contains the given keys.|
|[contains_same_key_value]({{site.baseurl}}/testing/assert-dictionary/#contains_same_key_value) | Verifies that the current dictionary contains the given key and value.|
|[not_contains_same_keys]({{site.baseurl}}/testing/assert-dictionary/#not_contains_same_keys) | Verifies that the current dictionary not contains the given keys.|

---

## Dictionary Assert Examples

### is_null

Verifies that the current value is null.
```gd
func assert_dict(<current>).is_null() -> GdUnitDictionaryAssert
```
```gd
# this assertion succeeds
assert_dict(null).is_null()

# should fail because the dictionary is not null
assert_dict({}).is_null()
```

### is_not_null

Verifies that the current value is not null.
```gd
func assert_dict(<current>).is_not_null() -> GdUnitDictionaryAssert
```
```gd
# this assertion succeeds
assert_dict({}).is_not_null()

# should fail because the dictionary is null
assert_dict(null).is_not_null()
```

### is_equal

Verifies that the current dictionary is equal to the given one, ignoring order.<br>
The values are compared by deep parameter comparision, for object reference compare you have to use [is_same]({{site.baseurl}}/testing/assert-dictionary/#is_same).<br>
For more details about comparision works see [How gunit Asserts compares Objects]({{site.baseurl}}/testing/assert/#how-gunit-asserts-compares-objects)
```gd
func assert_dict(<current>).is_equal(<expected>) -> GdUnitDictionaryAssert:
```
```gd
# this assertion succeeds
assert_dict({}).is_equal({})
assert_dict({1:1}).is_equal({1:1})
assert_dict({1:1, "key_a": "value_a"}).is_equal({1:1, "key_a": "value_a" })
# different order is also equals
assert_dict({"key_a": "value_a", 1:1}).is_equal({1:1, "key_a": "value_a" })

# should fail
assert_dict({}).is_equal({1:1})
assert_dict({1:1}).is_equal({1:2})
assert_dict({1:1, "key_a": "value_a"}).is_equal({1:1, "key_b": "value_b"})
```

### is_not_equal

Verifies that the current dictionary is not equal to the given one, ignoring order.<br>
The values are compared by deep parameter comparision, for object reference compare you have to use [is_not_same]({{site.baseurl}}/testing/assert-dictionary/#is_not_same).<br>
For more details about comparision works see [How gunit Asserts compares Objects]({{site.baseurl}}/testing/assert/#how-gunit-asserts-compares-objects)
```gd
func assert_dict(<current>).is_not_equal(<expected>) -> GdUnitDictionaryAssert:
```
```gd
# this assertion succeeds
assert_dict(null).is_not_equal({})
assert_dict({}).is_not_equal(null)
assert_dict({}).is_not_equal({1:1})
assert_dict({1:1}).is_not_equal({})
assert_dict({1:1}).is_not_equal({1:2})
assert_dict({2:1}).is_not_equal({1:1})
assert_dict({1:1}).is_not_equal({1:1, "key_a": "value_a"})
assert_dict({1:1, "key_a": "value_a"}).is_not_equal({1:1})
assert_dict({1:1, "key_a": "value_a"}).is_not_equal({1:1,"key_b": "value_b"})

# should fail
assert_dict({}).is_not_equal({})
assert_dict({1:1}).is_not_equal({1:1})
assert_dict({1:1, "key_a": "value_a"}).is_not_equal({1:1, "key_a": "value_a"})
assert_dict({"key_a": "value_a", 1:1}).is_not_equal({1:1, "key_a": "value_a"})
```

### is_same

Verifies that the current dictionary is the same.<br>
The dictionary are compared by object reference, for deep parameter comparision use [is_equal]({{site.baseurl}}/testing/assert-dictionary/#is_equal).<br>
For more details about comparision works see [How gunit Asserts compares Objects]({{site.baseurl}}/testing/assert/#how-gunit-asserts-compares-objects)

```gd
func assert_dict(<current>).is_same(<expected>) -> GdUnitDictionaryAssert:
```
```gd
var a := { "key_a": "value_a", "key_b": "value_b"}
var b := { "key_a": "value_a", "key_b": "value_b"}
# this assertion succeeds
assert_dict(a).is_same(a)

# should fail
assert_dict(a).is_same(b)
```

### is_not_same

Verifies that the current dictionary is NOT the same.<br>
The dictionary are compared by object reference, for deep parameter comparision use [is_not_equal]({{site.baseurl}}/testing/assert-dictionary/#is_not_equal).<br>
For more details about comparision works see [How gunit Asserts compares Objects]({{site.baseurl}}/testing/assert/#how-gunit-asserts-compares-objects)

```gd
func assert_dict(<current>).is_not_same(<expected>) -> GdUnitDictionaryAssert:
```
```gd
var a := { "key_a": "value_a", "key_b": "value_b"}
var b := { "key_a": "value_a", "key_b": "value_b"}
# this assertion succeeds
assert_dict(a).is_not_same(b)

# should fail
assert_dict(a).is_not_same(a)
```

### is_empty

Verifies that the current dictionary is empty, it has a size of 0.
```gd
func assert_dict(<current>).is_empty() -> GdUnitDictionaryAssert:
```
```gd
# this assertion succeeds
assert_dict({}).is_empty()

# should fail
assert_dict(null).is_empty()
assert_dict({1:1}).is_empty()
```

### is_not_empty

Verifies that the current dictionary is not empty, it has a size of minimum 1.
```gd
func assert_dict(<current>).is_not_empty() -> GdUnitDictionaryAssert:
```
```gd
# this assertion succeeds
assert_dict({1:1}).is_not_empty()
assert_dict({1:1, "key_a": "value_a"}).is_not_empty()

# should fail
assert_dict(null).is_not_empty()
assert_dict({}).is_not_empty()
```

### has_size

Verifies that the current dictionary has a size of given value.
```gd
func assert_dict(<current>).has_size(<expected>) -> GdUnitDictionaryAssert:
```
```gd
# this assertion succeeds
assert_dict({}).has_size(0)
assert_dict({1:1, 2:1, 3:1}).has_size(3)

# should fail
assert_dict(null).has_size(0)
assert_dict({}).has_size(1)
assert_dict({1:1, 2:1, 3:1}).has_size(4)
```

### contains_keys

Verifies that the current dictionary contains the given key(s).<br>
The values are compared by deep parameter comparision, for object reference compare you have to use [contains_same_keys]({{site.baseurl}}/testing/assert-dictionary/#contains_same_keys).<br>
For more details about comparision works see [How gunit Asserts compares Objects]({{site.baseurl}}/testing/assert/#how-gunit-asserts-compares-objects)
```gd
func assert_dict(<current>).contains_keys(<expected>) -> GdUnitDictionaryAssert:
```
```gd
# this assertion succeeds
assert_dict({1:1, 2:2, 3:3}).contains_keys(2)
assert_dict({1:1, 2:2, "key_a": "value_a"}).contains_keys(2, "key_a")


# should fail
assert_dict({1:1, 3:3}).contains_keys(2) # key 2 is missing
assert_dict({1:1, 3:3}).contains_keys(1, 4) # key 4 is missing
```

### contains_key_value

Verifies that the current dictionary contains the given key and value.<br>
The values are compared by deep parameter comparision, for object reference compare you have to use [contains_same_key_value]({{site.baseurl}}/testing/assert-dictionary/#contains_same_key_value).<br>
For more details about comparision works see [How gunit Asserts compares Objects]({{site.baseurl}}/testing/assert/#how-gunit-asserts-compares-objects)
```gd
func contains_key_value(<key>, <value>) -> GdUnitDictionaryAssert:
```
```gd
# this assertion succeeds
assert_dict({1:1}).contains_key_value(1, 1)
assert_dict({1:1, 2:2, 3:3}).contains_key_value(3, 3).contains_key_value(1, 1)

# should fail
assert_dict({1:1}.contains_key_value(1, 2) # contains key '1' but with value '2'
```

### not_contains_keys

Verifies that the current dictionary not contains the given key(s).<br>
The values are compared by deep parameter comparision, for object reference compare you have to use [not_contains_same_keys]({{site.baseurl}}/testing/assert-dictionary/#not_contains_same_keys).<br>
For more details about comparision works see [How gunit Asserts compares Objects]({{site.baseurl}}/testing/assert/#how-gunit-asserts-compares-objects)
```gd
func assert_dict(<current>).not_contains_keys(<expected>) -> GdUnitDictionaryAssert:
```
```gd
# this assertion succeeds
assert_dict({}).not_contains_keys(2)
assert_dict({1:1, 3:3}).not_contains_keys(2)
assert_dict({1:1, 3:3}).not_contains_keys(2, 4)

# should fail
assert_dict({1:1, 2:2, 3:3}).not_contains_keys(2, 4) # but contains 2
assert_dict({1:1, 2:2, 3:3}.not_contains_keys(1, 2, 3, 4) # but contains 1, 2, 3
```

### contains_same_keys

Verifies that the current dictionary contains the given key(s).<br>
The dictionary are compared by object reference, for deep parameter comparision use [contains_keys]({{site.baseurl}}/testing/assert-dictionary/#contains_keys).<br>
For more details about comparision works see [How gunit Asserts compares Objects]({{site.baseurl}}/testing/assert/#how-gunit-asserts-compares-objects)
```gd
func assert_dict(<current>).contains_same_keys(<expected>: Array) -> GdUnitDictionaryAssert:
```
```gd
var key_a := Node.new()
var key_b := Node.new()
var key_c := Node.new()
var dict_a := { key_a:"foo", key_b:"bar" }

# this assertion succeeds
assert_dict(dict_a).contains_same_keys([key_a])

# should fail
assert_dict(a).contains_same_keys([key_c]) # key_c is missing
```

### contains_same_key_value

Verifies that the current dictionary contains the given key and value.<br>
The values are compared by deep parameter comparision, for object reference compare you have to use [contains_key_value]({{site.baseurl}}/testing/assert-dictionary/#contains_key_value).<br>
For more details about comparision works see [How gunit Asserts compares Objects]({{site.baseurl}}/testing/assert/#how-gunit-asserts-compares-objects)
```gd
func contains_same_key_value(<key>, <value>) -> GdUnitDictionaryAssert:
```
```gd
var key_a := Node.new()
var key_b := Node.new()
var value_a := Node.new()
var value_b := Node.new()
var dict_a := { key_a:value_a, key_b:value_b }

# this assertion succeeds
assert_dict(dict_a)\
    .contains_same_key_value(key_a, value_a)\
    .contains_same_key_value(key_b, value_b)

# should fail  because it NOT contains key with value key_a, value_b
assert_dict(dict_a).contains_same_key_value(key_a, value_b)
```

### not_contains_same_keys

Verifies that the current dictionary not contains the given key(s).<br>
The values are compared by deep parameter comparision, for object reference compare you have to use [not_contains_keys]({{site.baseurl}}/testing/assert-dictionary/#not_contains_keys).<br>
For more details about comparision works see [How gunit Asserts compares Objects]({{site.baseurl}}/testing/assert/#how-gunit-asserts-compares-objects)
```gd
func assert_dict(<current>).not_contains_same_keys(<expected>) -> GdUnitDictionaryAssert:
```
```gd
var key_a := Node.new()
var key_b := Node.new()
var key_c := Node.new()
var dict_a := { key_a:"foo", key_b:"bar" }
# this assertion succeeds
assert_dict(dict_a).not_contains_same_keys(key_c)

# should fail because it contains key_a and key_b
assert_dict(dict_a).not_contains_same_keys(key_a)
assert_dict(dict_a).not_contains_same_keys(key_b)
```
