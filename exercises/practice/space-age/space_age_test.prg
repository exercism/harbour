* ----------------------------------------------------------------------------
* Harbour Unit Test Runner [space_age.prg]
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
do AddTestDatabase with TESTS, "Age on Earth", "==", "31.69", "AgeYearsOn('earth', 1000000000)"
do AddTestDatabase with TESTS, "Age on Mercury", "==", "280.88", "AgeYearsOn('mercury', 2134835688)"
do AddTestDatabase with TESTS, "Age on Venus", "==", "9.78", "AgeYearsOn('venus', 189839836)"
do AddTestDatabase with TESTS, "Age on Mars", "==", "35.88", "AgeYearsOn('mars', 2129871239)"
do AddTestDatabase with TESTS, "Age on Jupiter", "==", "2.41", "AgeYearsOn('jupiter', 901876382)"
do AddTestDatabase with TESTS, "Age on Saturn", "==", "2.15", "AgeYearsOn('saturn', 2000000000)"
do AddTestDatabase with TESTS, "Age on Uranus", "==", "0.46", "AgeYearsOn('uranus', 1210123456)"
do AddTestDatabase with TESTS, "Age on Neptune", "==", "0.35", "AgeYearsOn('neptune', 1821023456)"
do AddTestDatabase with TESTS, "Not a planet", "==", "NIL", "AgeYearsOn('sun', 680804807)"

* Execute unit tests. Arguments:
* - Tests database name
* - Database retention flag (.T. to not delete test database on test end)
* - JSON output flag (.T. to emit test results in JSON format [default is TAP])
SUCCESS := RunTests(TESTS, SToBool(hb_PValue(2)), SToBool(hb_PValue(3)))

* Return success status to OS
ERRORLEVEL(IIF(SUCCESS, 0, 1))

* Code under test (CUT)
#include "space_age.prg"

* Unit Test Framework
#include "PRGUNIT.prg"
