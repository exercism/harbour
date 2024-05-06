* ----------------------------------------------------------------------------
* Harbour Unit Test Runner [two_fer.prg]
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
do AddTestDatabase with TESTS, "No name given", "==", "One for you, one for me.", "TwoFer()"
do AddTestDatabase with TESTS, "A name given", "==", "One for Alice, one for me.", "TwoFer('Alice')"
do AddTestDatabase with TESTS, "Another name given", "==", "One for Bob, one for me.", "TwoFer('Bob')"
do AddTestDatabase with TESTS, "Handle arg with spaces", "==", "One for John Smith, one for me.", "TwoFer('John Smith')"
do AddTestDatabase with TESTS, "Name as empty string", "==", "One for you, one for me.", "TwoFer('')"


* Execute unit tests. Arguments:
* - Tests database name
* - Database retention flag (.T. to not delete test database on test end)
* - JSON output flag (.T. to emit test results in JSON format [default is TAP])
SUCCESS := RunTests(TESTS, SToBool(hb_PValue(2)), SToBool(hb_PValue(3)))

* Return success status to OS
ERRORLEVEL(IIF(SUCCESS, 0, 1))

* Code under test (CUT)
#include "two_fer.prg"

* Unit Test Framework
#include "PRGUNIT.prg"
