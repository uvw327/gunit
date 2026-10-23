---
layout: default
title: Continuous Integration Testing
nav_order: 10
---

# Continuous Integration Testing (CI)

## Definition

Continuous Integration (CI) is a method for automating the integration of code changes made by multiple contributors to a single software project.
It is a primary DevOps best practice that allows developers to frequently merge code changes into a central repository where builds and tests are executed.
Automated tools are used to confirm the new code is bug-free before integration.

[Wiki - Continuous Integration](https://en.wikipedia.org/wiki/Continuous_integration){:target="_blank"}

## Command Line Tool

gunit provides a command line tool that allows you to automate your testing workflow, including CI.

For more details please show at [Command Line Tool]({{site.baseurl}}/advanced_testing/cmd){:target="_blank"}

## Howto deploy with GitHub Action

To deploy with GitHub Actions, you need to create a new workflow file in the *\.github/workflows/* directory and name it *ci\.yml*.
Please visit [GitHub Workflows Page](https://docs.github.com/en/actions/using-workflows){:target="_blank"}

### Running gunit tests on GitHub Actions

The upstream *gdUnit4-action* installs official gdUnit4 releases and is therefore **not compatible with this fork**.
Instead, run the command line tool that ships with the addon: your repository already contains `addons/gunit`,
so you only need to provide a Godot binary (gunit v7 requires at least Godot 4.7), import the project once,
and execute `addons/gunit/runtest.sh`.

Example workflow: (Please note that this is just an example and needs to be adapted to your project environment.)
{% raw %}
```yaml
name: ci
run-name: ${{ github.head_ref || github.ref_name }}-ci

on:
  pull_request:
    paths-ignore:
      - '**.yml'
      - '**.md'
  workflow_dispatch:


concurrency:
  group: ci-${{ github.event.number || github.ref_name }}
  cancel-in-progress: true


jobs:
  unit-test:
    name: "CI Unit Test"
    runs-on: 'ubuntu-22.04'
    timeout-minutes: 10 # The overall timeout
    permissions:
      actions: write
      checks: write
      contents: write
      pull-requests: write
      statuses: write

    steps:
      # checkout your repository (contains the addon at addons/gunit)
      - uses: actions/checkout@v4
        with:
          lfs: true
      # download the official Godot binary (gunit v7 requires at least Godot 4.7)
      - name: Install Godot
        run: |
          curl -sL -o godot.zip https://github.com/godotengine/godot/releases/download/4.7.2-stable/Godot_v4.7.2-stable_linux.x86_64.zip
          unzip -q godot.zip
          chmod +x Godot_v4.7.2-stable_linux.x86_64
          echo "GODOT_BIN=$PWD/Godot_v4.7.2-stable_linux.x86_64" >> "$GITHUB_ENV"
      # import the project once to build the global class cache
      - name: Import project
        run: '$GODOT_BIN --headless --path . --import --quit'
      # run the tests by using the gunit command line tool
      # use '-c' to run the complete test set instead of aborting on the first failure
      - name: Run tests
        run: ./addons/gunit/runtest.sh -a res://test -c
      # collect the JUnit/HTML reports written to the reports folder
      - name: Upload test report
        if: always()
        uses: actions/upload-artifact@v4
        with:
          name: test-report
          path: reports/
```
{% endraw %}

Notes:

- `runtest.sh` needs the Godot binary either via the `GODOT_BIN` environment variable or the `--godot_binary` argument.
- On Windows runners use `addons\gunit\runtest.cmd` instead, or run the workflow inside WSL.
- The tool exits with a non-zero code when tests fail, which fails the workflow step as expected.
- Test reports are written to the `reports/` folder by default and can be configured in `res://.gunit.json`,
  see [Project Configuration]({{site.baseurl}}/first_steps/settings/#project-configuration).

## Howto deploy with GitLab CI

You have to create a new workflow file on GitLab and named it *\.gitlab-ci\.yml*.
Please visit [GitLab CI Documentation](https://docs.gitlab.com/ee/ci/yaml/gitlab_ci_yaml.html){:target="_blank"} for more detaild instructions

Thanks to [mzoeller](https://github.com/mzoeller){:target="_blank"} to providing this example workflow.
{% raw %}
```yaml
image: barichello/godot-ci:4.0.0

cache:
  key: import-assets
  paths:
    - .import/

stages:
  - export
  - tests
  - deploy

variables:
  EXPORT_NAME: $CI_PROJECT_NAME
  GIT_SUBMODULE_STRATEGY: recursive

linux:
  stage: export
  script:
    - mkdir -v -p build/linux
    - godot -v --export "Linux/X11" build/linux/$EXPORT_NAME.x86_64
  artifacts:
    name: $EXPORT_NAME-$CI_JOB_NAME
    paths:
      - build/linux

gunit:
  stage: tests
  dependencies:
    - linux
  script:
    - export GODOT_BIN=/usr/local/bin/godot
    - ./addons/gunit/runtest.sh -a ./test || if [ $? -eq 101 ]; then echo "warnings"; elif [ $? -eq 0 ]; then echo "success"; else exit 1; fi
  artifacts:
    when: always
    reports:
      junit: ./reports/report_1/results.xml
```
{% endraw %}
