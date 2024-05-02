* ----------------------------------------------------------------------------
* Harbour Unit Test Runner [acronym.prg]
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

do AddTestDatabase with TESTS, "Basic", "==", "PNG", "Abbreviate('Portable Network Graphics')"
do AddTestDatabase with TESTS, "Lowercase words", "==", "ROR", "Abbreviate('Ruby on Rails')"
do AddTestDatabase with TESTS, "Punctuation", "==", "FIFO", "Abbreviate('First In, First Out')"
do AddTestDatabase with TESTS, "All caps word", "==", "GIMP", "Abbreviate('GNU Image Manipulation Program')"
do AddTestDatabase with TESTS, "Punctuation without whitespace", "==", "CMOS", "Abbreviate('Complementary metal-oxide semiconductor')"
do AddTestDatabase with TESTS, "Very long abbreviation", "==", "ROTFLSHTMDCOALM", "Abbreviate('Roll On The Floor Laff So Hard That My Dog Came Over And Lick Me')"
do AddTestDatabase with TESTS, "Consecutive delimiters", "==", "SIMUFTA", "Abbreviate('Something - I made up from thin air')"
do AddTestDatabase with TESTS, "Apostrophes", "==", "HC", 'Abbreviate("Halley" + CHR(39) + "s Comet")'
do AddTestDatabase with TESTS, "Underscore emphasis", "==", "TRNT", "Abbreviate('The Road __Not__ Taken')"

* Execute unit tests. Arguments:
* - Tests database name
* - Database retention flag (.T. to not delete test database on test end)
* - JSON output flag (.T. to emit test results in JSON format [default is TAP])
SUCCESS := RunTests(TESTS, SToBool(hb_PValue(2)), SToBool(hb_PValue(3)))

* Return success status to OS
ERRORLEVEL(IIF(SUCCESS, 0, 1))

* Code under test (CUT)
#include "acronym.prg"

* Unit Test Framework
#include "PRGUNIT.prg"
