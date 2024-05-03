* ----------------------------------------------------------------------------
* Harbour Unit Test Runner [error_handling.prg]
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
do AddTestDatabase with TESTS, "Correct arguments", "==", "Hello, Alice", "HandleError('Alice')"
do AddTestDatabase with TESTS, "One long argument", "==", "Hello, Alice and Bob", "HandleError('Alice and Bob')"
do AddTestDatabase with TESTS, "Incorrect arguments", "==", "NIL", "HandleError('Alice', 'Bob')"
do AddTestDatabase with TESTS, "Return error indicator with no value given", "==", "NIL", "HandleError()"
do AddTestDatabase with TESTS, "Empty argument", "==", "Hello, ", "HandleError('')"

* Execute unit tests. Arguments:
* - Tests database name
* - Database retention flag (.T. to not delete test database on test end)
* - JSON output flag (.T. to emit test results in JSON format [default is TAP])
SUCCESS := RunTests(TESTS, SToBool(hb_PValue(2)), SToBool(hb_PValue(3)))

* Return success status to OS
ERRORLEVEL(IIF(SUCCESS, 0, 1))

* Code under test (CUT)
#include "error_handling.prg"

* Unit Test Framework
#include "PRGUNIT.prg"
