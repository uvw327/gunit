---
layout: default
title: Parameterized Tests
parent: Advanced Testing
nav_order: 4
---

# Testing with Parameterized TestCases

## Parameterized TestCases

Parameterized tests can help keep your test suite organized by allowing you to define multiple test scenarios with different inputs using a single
test function. You can define the required test parameters on the TestCase and use them in your test function to generate various test cases.
This is especially useful when you have similar test setups with different inputs.

To define a TestCase with parameters, you need to add input parameters and a test data set with the name **test_parameters**.
This TestCase will be executed multiple times with the test data provided by the **test_parameters** parameter.<br>
Here's an example:

```gd
func test_parameterized_int_values(a: int, b: int, c: int, expected: int, _test_parameters := [
     [1, 2, 3, 6],
     [3, 4, 5, 12],
     [6, 7, 8, 21] ]):
     
     assert_that(a+b+c).is_equal(expected)
```

💡 To avoid warnings about unused arguments, use the underscore prefix `_` or use `@warning_ignore(“unused_parameter”)`.

{% include advice.html
content="The TestCase dataset must match the required input parameters and types. If the parameters do not match, a corresponding error is reported."
%}

---
