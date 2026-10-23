---
layout: default
title: Error/Exception Assert
parent: Asserts
---

# Error Assertion

The error assertion functionality in gunit is designed to test for runtime errors in GdScript.
gunit leverages Godot's internal error reporting system to capture `push_error()`, `push_warning()`, and assertion
failures through the `assert_error()` function approach.

## How It Works

GdScript is Godot's native scripting language with built-in error handling mechanisms.
While GdScript errors are typically reported through Godot's logging system, `assert_error` intercepts these
messages so they can be verified inside a test.

In **GdScript**, `assert_error` tests for Godot runtime errors such as failing asserts, script runtime errors,
`push_error`, and `push_warning` messages.

**GdUnitGodotErrorAssert**<br>

|Function|Description|
|--- | --- |
|[is_success]({{site.baseurl}}/testing/assert-error/#testing-for-success)| Verifies if the executed code runs without any runtime errors.|
|[is_runtime_error]({{site.baseurl}}/testing/assert-error/#testing-for-assert-failed)| Verifies if the executed code runs into a runtime error.|
|[is_push_warning]({{site.baseurl}}/testing/assert-error/#testing-for-push-warnings-and-push-errors)| Verifies if the executed code has a push_warning() used.|
|[is_push_error]({{site.baseurl}}/testing/assert-error/#testing-for-push-warnings-and-push-errors)| Verifies if the executed code has a push_error() used.|

---

## GdScript Error Testing

### Testing for Success

To test whether a specific code snippet runs successfully without any errors, you can use the `is_success()` function with `assert_error`. Here's an example:

```gd
func assert_error(<Callable>).is_success() -> GdUnitGodotErrorAssert:
```
```gd
func test_is_success() -> void:
    await assert_error(func(): <code to execute>).is_success()
```

Replace `<code to execute>` with the actual code snippet you want to test. If the code executes without any runtime errors,
the test will pass; otherwise, it will fail.

### Testing for Assert Failed

You can use `assert_error` to verify that an assertion failure occurs during the execution of your code. This can help you ensure that your asserts
are working correctly. Here's an example:

```gd
func assert_error(<Callable>).is_runtime_error(<message>) -> GdUnitGodotErrorAssert:
```

```gd
func test_is_assert_failed() -> void:
    await assert_error(func(): <code to execute>)\
        .is_runtime_error('Assertion failed: this is an assert error')
```

Replace `<code to execute>` with the code snippet that contains the assertion you want to test. The `is_runtime_error` function checks whether the
expected assertion error message is generated. If the assertion fails as expected, the test will pass; otherwise, it will fail.

### Testing for Push Warnings and Push Errors

You can also use `assert_error` to test for specific push warnings and push errors that may occur during the execution of your code.
Here are examples for both cases:

```gd
func assert_error(<Callable>).is_push_warning(<message>) -> GdUnitGodotErrorAssert:
func assert_error(<Callable>).is_push_error(<message>) -> GdUnitGodotErrorAssert:
```
```gd
func test_is_push_warning() -> void:
    await assert_error(func(): <code to execute>)\
        .is_push_warning('this is a push_warning')

func test_is_push_error() -> void:
    await assert_error(func(): <code to execute>)\
        .is_push_error('this is a push_error')
```

Replace `<code to execute>` with the relevant code snippet that may generate a push warning or a push error. The `is_push_warning` and `is_push_error`
functions check whether the expected warning or error message is generated during code execution. If the message is generated as expected,
the test will pass; otherwise, it will fail.

## Conclusion

Error assertion capabilities in gunit provide comprehensive testing for expected runtime error conditions.
Use `assert_error` to verify failing asserts, script runtime errors, `push_error`, and `push_warning` messages
inside your GdScript test suites.
