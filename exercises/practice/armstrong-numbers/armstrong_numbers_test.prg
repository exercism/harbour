* ----------------------------------------------------------------------------
* Harbour Unit Test Runner [armstrong_numbers.prg]
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

do AddTestDatabase with TESTS, "Zero is Armstrong numbers", "==", ".T.", "IsArmstrongNumber(0)"
do AddTestDatabase with TESTS, "Single digits are Armstrong numbers", "==", ".T.", "IsArmstrongNumber(5)"
do AddTestDatabase with TESTS, "There are no two digit Armstrong numbers", "==", ".F.", "IsArmstrongNumber(10)"
do AddTestDatabase with TESTS, "A three digit number that is an Armstrong number", "==", ".T.", "IsArmstrongNumber(153)"
do AddTestDatabase with TESTS, "A three digit number that is not an Armstrong number", "==", ".F.", "IsArmstrongNumber(100)"
do AddTestDatabase with TESTS, "A four digit number that is an Armstrong number", "==", ".T.", "IsArmstrongNumber(9474)"
do AddTestDatabase with TESTS, "A four digit number that is not an Armstrong number", "==", ".F.", "IsArmstrongNumber(9475)"
do AddTestDatabase with TESTS, "A seven digit number that is an Armstrong number", "==", ".T.", "IsArmstrongNumber(9926315)"
do AddTestDatabase with TESTS, "A seven digit number that is not an Armstrong number", "==", ".F.", "IsArmstrongNumber(9926314)"
do AddTestDatabase with TESTS, "Armstrong number containing seven zeroes", "==", ".F.", "IsArmstrongNumber(1000700300)"

*** Test ommitted as language has no in-built support for arbitrary precision arithmetic (max. unsigned integer supported: 18446744073709551615)
*** do AddTestDatabase with TESTS, "The largest and last Armstrong number", "==", ".T.", "IsArmstrongNumber(115132219018763992565095597973971522401)"

* Execute unit tests. Arguments:
* - Tests database name
* - Database retention flag (.T. to not delete test database on test end)
* - JSON output flag (.T. to emit test results in JSON format [default is TAP])
SUCCESS := RunTests(TESTS, SToBool(hb_PValue(2)), SToBool(hb_PValue(3)))

* Return success status to OS
ERRORLEVEL(IIF(SUCCESS, 0, 1))

* Code under test (CUT)
#include "armstrong_numbers.prg"

* Unit Test Framework
#include "PRGUNIT.prg"
