* ----------------------------------------------------------------------------
* Harbour Unit Test Runner [difference_of_squares.prg]
* ----------------------------------------------------------------------------

* Variable declarations
memvar TESTS, SUCCESS

* Test database name
TESTS := IIF(PCOUNT() > 0, hb_PValue(1), "TESTS")

* Create tests database
do MakeTestDatabase with TESTS

* Add test data into tests database. Each test case stub should be altered
*  to follow this format:
*
* do AddTestDatabase with TESTS, "say Hi!", "==", "Hello, World!", "HelloWorld()"
* do AddTestDatabase with TESTS, "add 5 and 3", "==", "8", "Add_5_And_3(5, 3)"
*
* Note:
*  1st field is the test description (already supplied)
*  2nd field is comparator operator, usually "=="
*  3rd field is the function return result, always written as a string
*  4th field is the function (optionally with arguments), always written as a string
*

* Add test data into tests database
do AddTestDatabase with TESTS, "Square of sum 1", "==", "1", "SquareOfSum(1)"
do AddTestDatabase with TESTS, "Square of sum 5", "==", "225", "SquareOfSum(5)"
do AddTestDatabase with TESTS, "Square of sum 100", "==", "25502500", "SquareOfSum(100)"
do AddTestDatabase with TESTS, "Zero is an error", "==", "NIL", "SquareOfSum(0)"
do AddTestDatabase with TESTS, "Negative value is an error", "==", "NIL", "SquareOfSum(-1)"
do AddTestDatabase with TESTS, "Sum of squares 1", "==", "1", "SumOfSquares(1)"
do AddTestDatabase with TESTS, "Sum of squares 5", "==", "55", "SumOfSquares(5)"
do AddTestDatabase with TESTS, "Sum of squares 100", "==", "338350", "SumOfSquares(100)"
do AddTestDatabase with TESTS, "Zero is an error", "==", "NIL", "SumOfSquares(0)"
do AddTestDatabase with TESTS, "Negative value is an error", "==", "NIL", "SumOfSquares(-1)"
do AddTestDatabase with TESTS, "Difference of squares 1", "==", "0", "Difference(1)"
do AddTestDatabase with TESTS, "Difference of squares 5", "==", "170", "Difference(5)"
do AddTestDatabase with TESTS, "Difference of squares 100", "==", "25164150", "Difference(100)"
do AddTestDatabase with TESTS, "Zero is an error", "==", "NIL", "Difference(0)"
do AddTestDatabase with TESTS, "Negative value is an error", "==", "NIL", "Difference(-1)"

* Execute unit tests. Arguments:
* - Tests database name
* - Database retention flag (.T. to not delete test database on test end)
* - JSON output flag (.T. to emit test results in JSON format [default is TAP])
SUCCESS := RunTests(TESTS, SToBool(hb_PValue(2)), SToBool(hb_PValue(3)))

* Return success status to OS
ERRORLEVEL(IIF(SUCCESS, 0, 1))

* Code under test (CUT)
#include "difference_of_squares.prg"

* Unit Test Framework
#include "PRGUNIT.prg"
