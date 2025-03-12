# runSuite

## Description
`runSuite` is a Bash script that automates testing for command-line programs. It takes a list of test cases from a suite file, runs the specified program with different inputs, and checks if the output matches expected results. If any test fails, the script provides detailed feedback.

## Features
- Executes a program multiple times using test cases listed in a suite file.
- Compares actual output to expected output.
- Reports failed tests with input details and expected vs. actual output.
- Handles various error conditions gracefully.

## Usage
```bash
./runSuite.sh [suite-file] [program]
```
- **suite-file**: A text file listing the names of test cases (without file extensions).
- **program**: The command-line executable being tested.

### Example
Given a `suite.txt` file containing:
```
test1
test2
bigTest
```
And corresponding files:
- `test1.args` (optional command-line arguments)
- `test1.in` (optional input file)
- `test1.expect` (expected output file)

Run the test suite as follows:
```bash
./runSuite.sh suite.txt ./myprogram
```

## Output
If a test fails, the script prints:
```
Test failed: test2
Args:
(contents of test2.args, if available)
Input:
(contents of test2.in, if available)
Expected:
(contents of test2.expect)
Actual:
(contents of the actual program output)
```
If all tests pass, no output is produced.

## Error Handling
The script ensures:
- Correct usage by checking the number of arguments.
- That required files (`suite-file`, `.expect`) exist and are readable.
- If an `.args` or `.in` file exists but is unreadable, the test is skipped, and execution continues.
- The script exits with an error if necessary files are missing or unreadable.

## Temporary Files
- Temporary files are created using `mktemp` in `/tmp` to avoid conflicts.
- All temporary files are deleted before the script exits.

