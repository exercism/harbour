* ----------------------------------------------------------------------------
* Harbour Unit Test Worker
* Anthony J. Borla (ajborla@bigpond.com)
* ----------------------------------------------------------------------------

#ifndef UTILS_PRG
   #include "utils.prg"
#endif

procedure MakeTestDatabaseStructure(dbfName)
   * Creation overwites any existing database
   create &dbfName

   * Each record describes the structure of a FIELD
   append blank
   replace Field_name with "NAME", Field_type with "C",;
           Field_Len  with 80,     Field_dec  with 0
   append blank
   replace Field_name with "CMPOP", Field_type with "C",;
           Field_Len  with 2,       Field_dec  with 0
   append blank
   replace Field_name with "EXPVALUE", Field_type with "C",;
           Field_Len  with 80,         Field_dec  with 0
   append blank
   replace Field_name with "CMDSTR", Field_type with "C",;
           Field_Len  with 80,       Field_dec  with 0

   * Ensure data written to disk
   close &dbfName
return

procedure MakeTestDatabase(dbfName)
   local dbfStructure := dbfName + "_STRUCTURE"

   * Build test database from database structure file
   do MakeTestDatabaseStructure with dbfStructure
   create &dbfName from &dbfStructure

   * Ensure database structure file is removed
   dbfStructure := dbfStructure + ".dbf"
   erase &dbfStructure
return

procedure AddTestDatabase(dbfName, testName, cmpOp, expValue, cmdStr)
   * Load a test data record into tests database (note use of 'Wrap' to
   *  preserve spaces in expected value string)
   use &dbfName
   append blank
   replace &dbfName->NAME with testName
   replace &dbfName->CMPOP with cmpOp
   replace &dbfName->EXPVALUE with Wrap(expValue)
   replace &dbfName->CMDSTR with cmdStr
   close &dbfName
return

function RunTests(dbfName, keepTestDBF, outputJSON)
   local testName, cmpOp, expValue, cmdStr, retValue, testExpr
   local success := .T.

   use &dbfName

   * Determine, and print, number of tests (required for TAP)
   if outputJSON == NIL .OR. !outputJSON
      ? "1.." + LTRIM(STR(LASTREC()))
   endif

   * Execute unit tests
   do while !EOF()
      * Extract test data (note use of 'Unwrap' to extract space-preserved
      *  expected value string)
      testName := ALLTRIM(&dbfName->NAME)
      cmpOp := &dbfName->CMPOP
      expValue := Unwrap(ALLTRIM(&dbfName->EXPVALUE))
      cmdStr := ALLTRIM(&dbfName->CMDSTR)

      * Execute test, and build test expression
      retValue := TypeToS(&cmdStr)
      testExpr := '"' + retValue + '" ' + cmpOp + ' "' + expValue + '"'

      * If the parameter flag, outputJSON, is omitted, or set to .F., then
      *  emit test report in TAP format
      if outputJSON == NIL .OR. !outputJSON
         * Report test outcome - TAP
         if &testExpr
            ? "OK " + LTRIM(STR(RECNO())) + " - " + testName
         else
            * Single test failure signals failure of whole suite
            success := .F.
            ? "FAIL " + LTRIM(STR(RECNO())) + " - " + testName
         endif
      else
         * Report test outcome - JSON
         ? "JSON"
      endif

      * ... next test
      skip
   enddo

   * Emit final newline for neater output - TAP
   if outputJSON == NIL .OR. !outputJSON
      ?
   endif

   close &dbfName

   * If the parameter flag, keepTestDBF, is omitted, or set to .F., then
   *  remove the tests database
   if keepTestDBF == NIL .OR. !keepTestDBF
      dbfName := dbfName + ".dbf"
      erase &dbfName
   endif

return success

function TypeToS(value)
   * Use VALTYPE() instead of TYPE() to check type
   local typeValue := VALTYPE(value)

   switch typeValue
      * Array type (assume 1D array of non-aggregate elements),
      *  returns the concatenation of elements as a string
      case "A" ; return ArrToS(value)

      * Character type returned untouched
      case "C" ; return value

      * Date as "yyyymmdd"
      case "D" ; return DTOS(value)

      * Logical as literal string representation of self
      case "L" ; return IIF(value, ".T.", ".F.")

      * String-converted numerics are right-justified, so ensure are
      *  returned trimmed
      case "N" ; return ALLTRIM(STR(value))

      * Support use of NIL return type (usually to indicate error)
      case "U" ; return "NIL"
   endswitch

* Ignore the remaining types, just return NIL (likely runtime error)
return NIL

* Utilities to preserve leading and trailing spaces in strings as they
*  are stored into, and extracted from, database fields
function Wrap(string) ; return WrapString(string, .F., "[", "]")
function Unwrap(string) ; return WrapString(string, .T.)

function WrapString(string, doUnwrap, wrapStart, wrapEnd)
   local uws
   if doUnwrap
      uws := SUBSTR(SUBSTR(string, 2), 1, LEN(string) - 2)
   else
      uws := wrapStart + string + wrapEnd
   endif
return uws

