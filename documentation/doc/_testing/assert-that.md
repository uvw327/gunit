---
layout: default
title: AssertThat
parent: Asserts
nav_order: 0
---

# AssertThat Assertions

The assert_that is useful when you don't know the type of the value you want to test.<br>
You can use this assertion on all types you want, but for better readability of the test (GdScript) I prefer to use type store asserts.

---

## AssertThat Example

Asserts are restricted by GdScript behavior and therefore do not fully support generics, i.e. you should prefer to use assert by type.<br>
```gd
func assert_that(<current>)
```
```gd
assert_that("This is a test message").is_equal("This is a test message")
assert_that(23).is_greater(20)
```
