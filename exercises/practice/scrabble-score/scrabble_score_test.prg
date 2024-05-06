* ----------------------------------------------------------------------------
* Harbour Unit Test Runner [scrabble_score.prg]
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
do AddTestDatabase with TESTS, "Lowercase letter", "==", "1", "Score('a')"
do AddTestDatabase with TESTS, "Uppercase letter", "==", "1", "Score('A')"
do AddTestDatabase with TESTS, "Valuable letter", "==", "4", "Score('f')"
do AddTestDatabase with TESTS, "Short word", "==", "2", "Score('at')"
do AddTestDatabase with TESTS, "Short, valuable word", "==", "12", "Score('zoo')"
do AddTestDatabase with TESTS, "Medium word", "==", "6", "Score('street')"
do AddTestDatabase with TESTS, "Medium, valuable word", "==", "22", "Score('quirky')"
do AddTestDatabase with TESTS, "Long, mixed-case word", "==", "41", "Score('OxyphenButazone')"
do AddTestDatabase with TESTS, "English-like word", "==", "8", "Score('pinata')"
do AddTestDatabase with TESTS, "Empty input", "==", "0", "Score('')"
do AddTestDatabase with TESTS, "Entire alphabet available", "==", "87", "Score('abcdefghijklmnopqrstuvwxyz')"

* Execute unit tests. Arguments:
* - Tests database name
* - Database retention flag (.T. to not delete test database on test end)
* - JSON output flag (.T. to emit test results in JSON format [default is TAP])
SUCCESS := RunTests(TESTS, SToBool(hb_PValue(2)), SToBool(hb_PValue(3)))

* Return success status to OS
ERRORLEVEL(IIF(SUCCESS, 0, 1))

* Code under test (CUT)
#include "scrabble_score.prg"

* Unit Test Framework
#include "PRGUNIT.prg"
