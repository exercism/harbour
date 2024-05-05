* ----------------------------------------------------------------------------
* Harbour Miscellaneous Utilities
* Anthony J. Borla (ajborla@bigpond.com)
* ----------------------------------------------------------------------------

#define UTILS_PRG

*
* Given a string, charSet, interpreted as a set of individual characters,
*  and a string, string, returns a copy of string with all occurrences of
*  the characters in charSet, removed.
*
function RemoveCharSet(charSet, string)
   local i, clen := LEN(charSet)
   for i := 1 to clen
      string := STRTRAN(string, SUBSTR(charSet, i, 1))
   next
return string

*
* Given a string, and a separator string (usually a single character)
*  returns an array of separator-split tokens, or the original string
*  if separation not possible.
*
function SToArr(string, separator)
   local array := {}, i, element

   * Return untouched string if no separator, or it is not in string
   if PCOUNT() < 2 .OR. separator == NIL ; return string ; endif
   i := AT(separator, string) ; if i == 0 ; return string ; endif

   * Parse the string, extracting each element, and adding to array
   do while i <> 0
      element := LEFT(string, i - 1)
      if !EMPTY(element) ; AADD(array, element) ; endif
      string := SUBSTR(string, i + 1)
      i := AT(separator, string)
   enddo

   * Handle last element, and return array
   if !EMPTY(string) ; AADD(array, string) ; endif
return array

*
* Given an array whose elements are non-aggregate types, returns a
*  string of those elements separated by separator. If a string
*  cannot be built, an empty string is returned.
*
function ArrToS(array, separator)
   local i, element, string := "", arrlen := LEN(array)
   if PCOUNT() < 2 .OR. separator == NIL ; separator := "" ; endif
   if arrlen < 1 ; return "" ; endif
   for i := 1 to arrlen
      element := IIF(VALTYPE(array[i]) <> "C", ALLTRIM(STR(array[i])), array[i])
      string += element + separator
   next
return ;
   IIF(EMPTY(separator), string, SUBSTR(string, 1, RAT(separator, string) - 1))

*
* Given a string, returns the Boolean status indicating whether
*  it is convertible to an integer. Non-numeric and floating
*  point values will both return .F.
*
function IsINTString(s)
   local slen, i
   if PCOUNT() <> 1 .OR. VALTYPE(s) <> "C" ; return .F. ; endif
   slen := LEN(s)
   if AT(".", s) <> 0 .OR. slen < 1 ; return .F. ; endif
   if VAL(s) <> 0 ; return .T. ; endif
   for i := 1 to slen
      if !(SUBSTR(s, i, 1) $ "0123456789") ; return .F. ; endif
   next
return .T.

*
* Given a string, returns the Boolean value represented.
*
function SToBool(s)
return ;
   IIF(VALTYPE(s) <> "C", NIL, ;
      IIF(UPPER(s) == ".T.", .T., ;
         IIF(UPPER(s) == ".F.", .F., ;
            IIF(SUBSTR(s, 1, 1) $ 'Tt', .T., ;
               IIF(SUBSTR(s, 1, 1) $ 'Ff', .F., NIL)))))

