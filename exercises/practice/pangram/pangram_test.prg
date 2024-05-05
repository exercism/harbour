* ----------------------------------------------------------------------------
* Harbour Unit Test Runner [pangram.prg]
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
do AddTestDatabase with TESTS, "Empty sentence", "==", ".F.", "IsPangram('')"
do AddTestDatabase with TESTS, "Perfect lower case", "==", ".T.", "IsPangram('abcdefghijklmnopqrstuvwxyz')"
do AddTestDatabase with TESTS, "Only lower case", "==", ".T.", "IsPangram('the quick brown fox jumps over the lazy dog')"
do AddTestDatabase with TESTS, "Missing the letter 'x'", "==", ".F.", "IsPangram('a quick movement of the enemy will jeopardize five gunboats')"
do AddTestDatabase with TESTS, "Missing the letter 'h'", "==", ".F.", "IsPangram('five boxing wizards jump quickly at it')"
do AddTestDatabase with TESTS, "With underscores", "==", ".T.", "IsPangram('the_quick_brown_fox_jumps_over_the_lazy_dog')"
do AddTestDatabase with TESTS, "With numbers", "==", ".T.", "IsPangram('the 1 quick brown fox jumps over the 2 lazy dogs')"
do AddTestDatabase with TESTS, "Missing letters replaced by numbers", "==", ".F.", "IsPangram('7h3 qu1ck brown fox jumps ov3r 7h3 lazy dog')"
do AddTestDatabase with TESTS, "Mixed case and punctuation", "==", ".T.", "IsPangram(CHR(34)+'Five quacking Zephyrs jolt my wax bed.'+CHR(34))"
do AddTestDatabase with TESTS, "A-M and a-m are 26 different characters but not a pangram", "==", ".F.", "IsPangram('abcdefghijklm ABCDEFGHIJKLM')"

* Execute unit tests. Arguments:
* - Tests database name
* - Database retention flag (.T. to not delete test database on test end)
* - JSON output flag (.T. to emit test results in JSON format [default is TAP])
SUCCESS := RunTests(TESTS, SToBool(hb_PValue(2)), SToBool(hb_PValue(3)))

* Return success status to OS
ERRORLEVEL(IIF(SUCCESS, 0, 1))

* Code under test (CUT)
#include "pangram.prg"

* Unit Test Framework
#include "PRGUNIT.prg"
