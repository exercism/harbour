* ----------------------------------------------------------------------------
* Harbour Unit Test Runner [gigasecond.prg]
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
do AddTestDatabase with TESTS, "Date only specificaion of time", "==", "2043-01-01T01:46:40", "From('2011-04-25')"
do AddTestDatabase with TESTS, "Second test for date only specification of time", "==", "2009-02-19T01:46:40", "From('1977-06-13')"
do AddTestDatabase with TESTS, "Third test for date only specification of time", "==", "1991-03-27T01:46:40", "From('1959-07-19')"
do AddTestDatabase with TESTS, "Full time specified", "==", "2046-10-02T23:46:40", "From('2015-01-24T22:00:00')"
do AddTestDatabase with TESTS, "Full time with day roll-over", "==", "2046-10-03T01:46:39", "From('2015-01-24T23:59:59')"

* Execute unit tests. Arguments:
* - Tests database name
* - Database retention flag (.T. to not delete test database on test end)
* - JSON output flag (.T. to emit test results in JSON format [default is TAP])
SUCCESS := RunTests(TESTS, SToBool(hb_PValue(2)), SToBool(hb_PValue(3)))

* Return success status to OS
ERRORLEVEL(IIF(SUCCESS, 0, 1))

* Code under test (CUT)
#include "gigasecond.prg"

* Unit Test Framework
#include "PRGUNIT.prg"
