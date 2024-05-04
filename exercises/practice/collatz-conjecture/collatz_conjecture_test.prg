* ----------------------------------------------------------------------------
* Harbour Unit Test Runner [collatz_conjecture.prg]
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

do AddTestDatabase with TESTS, "Zero steps for one", "==", "0", "Steps(1)"
do AddTestDatabase with TESTS, "Divide if even", "==", "4", "Steps(16)"
do AddTestDatabase with TESTS, "Even and odd steps", "==", "9", "Steps(12)"
do AddTestDatabase with TESTS, "Large number of even and odd steps", "==", "152", "Steps(1000000)"
do AddTestDatabase with TESTS, "No input should return an error", "==", "NIL", "Steps()"
do AddTestDatabase with TESTS, "Zero is an error", "==", "NIL", "Steps(0)"
do AddTestDatabase with TESTS, "Negative value is an error", "==", "NIL", "Steps(-15)"

* Execute unit tests. Arguments:
* - Tests database name
* - Database retention flag (.T. to not delete test database on test end)
* - JSON output flag (.T. to emit test results in JSON format [default is TAP])
SUCCESS := RunTests(TESTS, SToBool(hb_PValue(2)), SToBool(hb_PValue(3)))

* Return success status to OS
ERRORLEVEL(IIF(SUCCESS, 0, 1))

* Code under test (CUT)
#include "collatz_conjecture.prg"

* Unit Test Framework
#include "PRGUNIT.prg"
