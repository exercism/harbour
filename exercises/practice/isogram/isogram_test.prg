* ----------------------------------------------------------------------------
* Harbour Unit Test Runner [isogram.prg]
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
do AddTestDatabase with TESTS, "Empty string", "==", ".T.", "IsIsogram('')"
do AddTestDatabase with TESTS, "Isogram with only lower case characters", "==", ".T.", "IsIsogram('isogram')"
do AddTestDatabase with TESTS, "Word with one duplicated character", "==", ".F.", "IsIsogram('eleven')"
do AddTestDatabase with TESTS, "Word with one duplicated character from the end of the alphabet", "==", ".F.", "IsIsogram('zzyzx')"
do AddTestDatabase with TESTS, "Longest reported english isogram", "==", ".T.", "IsIsogram('subdermatoglyphic')"
do AddTestDatabase with TESTS, "Word with duplicated character in mixed case", "==", ".F.", "IsIsogram('Alphabet')"
do AddTestDatabase with TESTS, "Hypothetical isogrammic word with hyphen", "==", ".T.", "IsIsogram('thumbscrew-japingly')"
do AddTestDatabase with TESTS, "Isogram with duplicated hyphen", "==", ".T.", "IsIsogram('six-year-old')"
do AddTestDatabase with TESTS, "Hypothetical word with duplicated character following hyphen", "==", ".F.", "IsIsogram('thumbscrew-jappingly')"
do AddTestDatabase with TESTS, "Made-up name that is an isogram", "==", ".T.", "IsIsogram('Emily Jung Schwartzkopf')"
do AddTestDatabase with TESTS, "Duplicated character in the middle", "==", ".F.", "IsIsogram('accentor')"
do AddTestDatabase with TESTS, "Word with duplicated character in mixed case, lowercase first", "==", ".F.", "IsIsogram('alphAbet')"
do AddTestDatabase with TESTS, "Same first and last characters", "==", ".F.", "IsIsogram('angola')"

* Execute unit tests. Arguments:
* - Tests database name
* - Database retention flag (.T. to not delete test database on test end)
* - JSON output flag (.T. to emit test results in JSON format [default is TAP])
SUCCESS := RunTests(TESTS, SToBool(hb_PValue(2)), SToBool(hb_PValue(3)))

* Return success status to OS
ERRORLEVEL(IIF(SUCCESS, 0, 1))

* Code under test (CUT)
#include "isogram.prg"

* Unit Test Framework
#include "PRGUNIT.prg"
