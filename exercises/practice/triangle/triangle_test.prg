* ----------------------------------------------------------------------------
* Harbour Unit Test Runner [triangle.prg]
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
do AddTestDatabase with TESTS, "All sides are equal, equilateral", "==", ".T.", "IsEquilateral(2, 2, 2)"
do AddTestDatabase with TESTS, "Any side is unequal", "==", ".F.", "IsEquilateral(2, 3, 2)"
do AddTestDatabase with TESTS, "No sides are equal, equilateral", "==", ".F.", "IsEquilateral(5, 4, 6)"
do AddTestDatabase with TESTS, "All zero sides is not a triangle", "==", ".F.", "IsEquilateral(0, 0, 0)"
do AddTestDatabase with TESTS, "Sides may be floats, equilateral", "==", ".T.", "IsEquilateral(0.5, 0.5, 0.5)"
do AddTestDatabase with TESTS, "Last two sides are equal", "==", ".T.", "IsIsosceles(3, 4, 4)"
do AddTestDatabase with TESTS, "First two sides are equal", "==", ".T.", "IsIsosceles(4, 4, 3)"
do AddTestDatabase with TESTS, "First and last sides are equal", "==", ".T.", "IsIsosceles(4, 3, 4)"
do AddTestDatabase with TESTS, "Equilateral triangles are also isosceles", "==", ".T.", "IsIsosceles(4, 4, 4)"
do AddTestDatabase with TESTS, "No sides are equal, isosceles", "==", ".F.", "IsIsosceles(2, 3, 4)"
do AddTestDatabase with TESTS, "First triangle inequality violation", "==", ".F.", "IsIsosceles(1, 1, 3)"
do AddTestDatabase with TESTS, "Second triangle inequality violation", "==", ".F.", "IsIsosceles(1, 3, 1)"
do AddTestDatabase with TESTS, "Third triangle inequality violation", "==", ".F.", "IsIsosceles(3, 1, 1)"
do AddTestDatabase with TESTS, "Sides may be floats, isosceles", "==", ".T.", "IsIsosceles(0.5, 0.4, 0.5)"
do AddTestDatabase with TESTS, "No sides are equal, scalene", "==", ".T.", "IsScalene(5, 4, 6)"
do AddTestDatabase with TESTS, "All sides are equal, scalene", "==", ".F.", "IsScalene(4, 4, 4)"
do AddTestDatabase with TESTS, "First and second sides are equal", "==", ".F.", "IsScalene(4, 4, 3)"
do AddTestDatabase with TESTS, "First and third sides are equal", "==", ".F.", "IsScalene(3, 4, 3)"
do AddTestDatabase with TESTS, "Second and third sides are equal", "==", ".F.", "IsScalene(4, 3, 3)"
do AddTestDatabase with TESTS, "May not violate triangle inequality", "==", ".F.", "IsScalene(7, 3, 2)"
do AddTestDatabase with TESTS, "Sides may be floats, scalene", "==", ".T.", "IsScalene(0.5, 0.4, 0.6)"

* Execute unit tests. Arguments:
* - Tests database name
* - Database retention flag (.T. to not delete test database on test end)
* - JSON output flag (.T. to emit test results in JSON format [default is TAP])
SUCCESS := RunTests(TESTS, SToBool(hb_PValue(2)), SToBool(hb_PValue(3)))

* Return success status to OS
ERRORLEVEL(IIF(SUCCESS, 0, 1))

* Code under test (CUT)
#include "triangle.prg"

* Unit Test Framework
#include "PRGUNIT.prg"
