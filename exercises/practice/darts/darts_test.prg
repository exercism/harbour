* ----------------------------------------------------------------------------
* Harbour Unit Test Runner [darts.prg]
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
do AddTestDatabase with TESTS, "Missed target", "==", "0", "Score(-9, 9)"
do AddTestDatabase with TESTS, "On the outer circle", "==", "1", "Score(0, 10)"
do AddTestDatabase with TESTS, "On the middle circle", "==", "5", "Score(-5, 0)"
do AddTestDatabase with TESTS, "On the inner circle", "==", "10", "Score(0, -1)"
do AddTestDatabase with TESTS, "Exactly on centre", "==", "10", "Score(0, 0)"
do AddTestDatabase with TESTS, "Near the centre", "==", "10", "Score(-0.1, -0.1)"
do AddTestDatabase with TESTS, "Just within the inner circle", "==", "10", "Score(0.7, 0.7)"
do AddTestDatabase with TESTS, "Just outside the inner circle", "==", "5", "Score(0.8, -0.8)"
do AddTestDatabase with TESTS, "Just within the middle circle", "==", "5", "Score(-3.5, 3.5)"
do AddTestDatabase with TESTS, "Just outside the middle circle", "==", "1", "Score(-3.6, -3.6)"
do AddTestDatabase with TESTS, "Just within the outer circle", "==", "1", "Score(-7.0, 7.0)"
do AddTestDatabase with TESTS, "Just outside the outer circle", "==", "0", "Score(7.1, -7.1)"
do AddTestDatabase with TESTS, "Asymmetric position between the inner and middle circles", "==", "5", "Score(0.5, -4)"

* Execute unit tests. Arguments:
* - Tests database name
* - Database retention flag (.T. to not delete test database on test end)
* - JSON output flag (.T. to emit test results in JSON format [default is TAP])
SUCCESS := RunTests(TESTS, SToBool(hb_PValue(2)), SToBool(hb_PValue(3)))

* Return success status to OS
ERRORLEVEL(IIF(SUCCESS, 0, 1))

* Code under test (CUT)
#include "darts.prg"

* Unit Test Framework
#include "PRGUNIT.prg"
