# testcli

Package **testcli** is a golang utility package for testing command line
interfaces ([CLI](https://en.wikipedia.org/wiki/Command-line_interface)).  When
using testcli, each CLI test exists within its own file system folder. All test
folders for a specific CLI are typically contained within a main folder which
the testcli package "walks" entering all subdirs and executing each CLI test
within a folder. Test results are tracked and displayed using the golang
standard testing infrastructure.

Each test folder must contain the following text files:

```text
* tCmd     : The CLI command to be executed including parameters and
             options.  Within this file any '{{.cli}}' string is replaced
             by the CLI being tested.  If a test folder is multiple levels
             deep within the file tree the relative CLI path is adjusted
             accordingly before executing tCmd.
* tStdout  : The expected stdout
* tStderr  : The expected sterr
* tExit    : The exit code
```

The following are optional files:

```text
* t*.check : Any file matching t*.check is compared directly against the
             same filename t*.result.  This can be used to check the
             output of any files generated by the CLI.
```

Alternately, any of the output filenames above may end with "Regex" to do a
regular expression match rather than a direct string comparison.  This can be
useful to check output for which a portion changes often.  For example log file
output that contains the date or time at the beginning of an output line.

```text
* tStdoutRegex   : Contains a regular expression string to match against
                   the expected stdout
* t*.checkRegex
* etc. ...
```

The following file names are not used directly by testcli but are named as
follows by convention if needed:

```text
* tStdin   : Any text intended to be fed as stdin to the CLI.  Typically
             this is accomplished within tCmd such as "{{.cli}} < tStdin"
```

Note that test folder names serve as the test description and are displayed
when a test fails or when using "go test -v". Also note that folders can be
nested as many levels deep as desired to categorize and group tests.

## Functions

```text
func RunTests(t *testing.T, cliPath string)
    RunTests iterates through all of the tests at or below the current path
    using the specified CLI. The CLI path can be absolute or relative.
```

## Example usage

A full example demontrating the use of testcli is contained within the "tests"
folder of this package.  A simple single test example is described below.

### Example folder structure

```text
tests
|-- example.sh
|-- example_test.go
|-- 5-a
    |-- tCmd
    |-- tExit
    |-- tStderr
    |-- tStdout
```

### Example files

#### tests/example.sh (description)

```text
Purpose:  A trivial demonstration script. The argument string is processed
          and printed to stdout.  Everything up to and including the first
          letter "a" is deleted, and everything after and including the
          last letter "a" is also deleted.
Usage:    example.sh string
```

#### tests/example_test.go (contents)

```text
package example_test

import (
    "git.lenzplace.org/lenzj/testcli"
    "testing"
)

func TestExample(t *testing.T) {
    testcli.RunTests(t, "./example.sh")
}
```

#### tests/5-a/tCmd (contents)

```text
{{.cli}} "The rain in Spain falls mainly in the plain" 
```

#### tests/5-a/tExit (contents)

```text
0
```

#### tests/5-a/tStderr (contents empty)

```text
File is empty
```

#### tests/5-a/tStdout (contents)

```text
in in Spain falls mainly in the pl
```

### Example passing test output

```text
$ go test -v
=== RUN   TestExample
=== RUN   TestExample/5-a
--- PASS: TestExample (0.01s)
    --- PASS: TestExample/5-a (0.01s)
PASS
ok      git.lenzplace.org/lenzj/testcli/tests     0.01s
```

### Example failing test output

Changed the last "a" in tests/5-a/tCmd to "A".

```text
$ go test -v
=== RUN   TestExample
=== RUN   TestExample/5-a
--- FAIL: TestExample (0.01s)
    --- FAIL: TestExample/5-a (0.01s)
        testcli.go:137: stdout:
             expected "in in Spain falls mainly in the pl\n"
             received "in in Spain falls m\n"
FAIL
exit status 1
FAIL git.lenzplace.org/lenzj/testcli/tests 0.01s
```

## Running the full package tests

```text
$ make check
  --or--
$ cd tests && go test -v
```

## Contributing

If you have a bugfix, update, issue or feature enhancement the best way to reach
me is by following the instructions in the link below.  Thank you!

<https://blog.lenzplace.org/about/contact.html>


## Versioning

I follow the [SemVer](http://semver.org/) strategy for versioning. The latest
version is listed in the [releases](/lenzj/testcli/releases) section. 


## License

This project is licensed under a BSD two clause license - see the
[LICENSE](LICENSE) file for details.


<!-- vim:set ts=4 sw=4 et tw=80: -->
