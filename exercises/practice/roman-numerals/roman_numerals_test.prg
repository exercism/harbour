* ----------------------------------------------------------------------------
* Harbour Unit Test Runner [roman_numerals.prg]
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
do AddTestDatabase with TESTS, "1 is one I", "==", "I", "Roman(1)"
do AddTestDatabase with TESTS, "2 is two I's", "==", "II", "Roman(2)"
do AddTestDatabase with TESTS, "3 is three I's", "==", "III", "Roman(3)"
do AddTestDatabase with TESTS, "4, being 5 - 1, is IV", "==", "IV", "Roman(4)"
do AddTestDatabase with TESTS, "5 is a single V", "==", "V", "Roman(5)"
do AddTestDatabase with TESTS, "6, being 5 + 1, is VI", "==", "VI", "Roman(6)"
do AddTestDatabase with TESTS, "9, being 10 - 1, is IX", "==", "IX", "Roman(9)"
do AddTestDatabase with TESTS, "20 is two X's", "==", "XXVII", "Roman(27)"
do AddTestDatabase with TESTS, "48 is not 50 - 2 but rather 40 + 8", "==", "XLVIII", "Roman(48)"
do AddTestDatabase with TESTS, "49 is not 40 + 5 + 4 but rather 50 - 10 + 10 - 1", "==", "XLIX", "Roman(49)"
do AddTestDatabase with TESTS, "50 is a single L", "==", "LIX", "Roman(59)"
do AddTestDatabase with TESTS, "90, being 100 - 10, is XC", "==", "XCIII", "Roman(93)"
do AddTestDatabase with TESTS, "100 is a single C", "==", "CXLI", "Roman(141)"
do AddTestDatabase with TESTS, "60, being 50 + 10, is LX", "==", "CLXIII", "Roman(163)"
do AddTestDatabase with TESTS, "400, being 500 - 100, is CD", "==", "CDII", "Roman(402)"
do AddTestDatabase with TESTS, "500 is a single D", "==", "DLXXV", "Roman(575)"
do AddTestDatabase with TESTS, "900, being 1000 - 100, is CM", "==", "CMXI", "Roman(911)"
do AddTestDatabase with TESTS, "1000 is a single M", "==", "MXXIV", "Roman(1024)"
do AddTestDatabase with TESTS, "3000 is three M's", "==", "MMM", "Roman(3000)"
do AddTestDatabase with TESTS, "16 is XVI", "==", "XVI", "Roman(16)"
do AddTestDatabase with TESTS, "66 is LXVI", "==", "LXVI", "Roman(66)"
do AddTestDatabase with TESTS, "166 is CLXVI", "==", "CLXVI", "Roman(166)"
do AddTestDatabase with TESTS, "666 is DCLXVI", "==", "DCLXVI", "Roman(666)"
do AddTestDatabase with TESTS, "1666 is MDCLXVI", "==", "MDCLXVI", "Roman(1666)"
do AddTestDatabase with TESTS, "3999 is MMMCMXCIX", "==", "MMMCMXCIX", "Roman(3999)"
do AddTestDatabase with TESTS, "4000 exceeds range", "==", "NIL", "Roman(4000)"
do AddTestDatabase with TESTS, "0 is below range", "==", "NIL", "Roman(0)"

* Execute unit tests. Arguments:
* - Tests database name
* - Database retention flag (.T. to not delete test database on test end)
* - JSON output flag (.T. to emit test results in JSON format [default is TAP])
SUCCESS := RunTests(TESTS, SToBool(hb_PValue(2)), SToBool(hb_PValue(3)))

* Return success status to OS
ERRORLEVEL(IIF(SUCCESS, 0, 1))

* Code under test (CUT)
#include "roman_numerals.prg"

* Unit Test Framework
#include "PRGUNIT.prg"
