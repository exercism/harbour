* ----------------------------------------------------------------------------
* Harbour Unit Test Runner [raindrops.prg]
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
do AddTestDatabase with TESTS, "The sound for 1 is 1", "==", "1", "Sounds(1)"
do AddTestDatabase with TESTS, "The sound for 3 is Pling", "==", "Pling", "Sounds(3)"
do AddTestDatabase with TESTS, "The sound for 5 is Plang", "==", "Plang", "Sounds(5)"
do AddTestDatabase with TESTS, "The sound for 7 is Plong", "==", "Plong", "Sounds(7)"
do AddTestDatabase with TESTS, "The sound for 6 is Pling as it has a factor 3", "==", "Pling", "Sounds(6)"
do AddTestDatabase with TESTS, "2^3 does not make a raindrop sound as 3 is the exponent not the base", "==", "8", "Sounds(8)"
do AddTestDatabase with TESTS, "The sound for 9 is Pling as it has a factor 3", "==", "Pling", "Sounds(9)"
do AddTestDatabase with TESTS, "The sound for 10 is Plang as it has a factor 5", "==", "Plang", "Sounds(10)"
do AddTestDatabase with TESTS, "The sound for 14 is Plong as it has a factor of 7", "==", "Plong", "Sounds(14)"
do AddTestDatabase with TESTS, "The sound for 15 is PlingPlang as it has factors 3 and 5", "==", "PlingPlang", "Sounds(15)"
do AddTestDatabase with TESTS, "The sound for 21 is PlingPlong as it has factors 3 and 7", "==", "PlingPlong", "Sounds(21)"
do AddTestDatabase with TESTS, "The sound for 25 is Plang as it has a factor 5", "==", "Plang", "Sounds(25)"
do AddTestDatabase with TESTS, "The sound for 27 is Pling as it has a factor 3", "==", "Pling", "Sounds(27)"
do AddTestDatabase with TESTS, "The sound for 35 is PlangPlong as it has factors 5 and 7", "==", "PlangPlong", "Sounds(35)"
do AddTestDatabase with TESTS, "The sound for 49 is Plong as it has a factor 7", "==", "Plong", "Sounds(49)"
do AddTestDatabase with TESTS, "The sound for 52 is 52", "==", "52", "Sounds(52)"
do AddTestDatabase with TESTS, "The sound for 105 is PlingPlangPlong as it has factors 3, 5 and 7", "==", "PlingPlangPlong", "Sounds(105)"
do AddTestDatabase with TESTS, "The sound for 3125 is Plang as it has a factor 5", "==", "Plang", "Sounds(3125)"

* Execute unit tests. Arguments:
* - Tests database name
* - Database retention flag (.T. to not delete test database on test end)
* - JSON output flag (.T. to emit test results in JSON format [default is TAP])
SUCCESS := RunTests(TESTS, SToBool(hb_PValue(2)), SToBool(hb_PValue(3)))

* Return success status to OS
ERRORLEVEL(IIF(SUCCESS, 0, 1))

* Code under test (CUT)
#include "raindrops.prg"

* Unit Test Framework
#include "PRGUNIT.prg"
