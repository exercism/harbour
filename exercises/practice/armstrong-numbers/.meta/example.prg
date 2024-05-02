* ----------------------------------------------------------------------------
* exercism.org
* Harbour Track Exercise: armstrong-numbers
* Contributed: Anthony J. Borla (ajborla@bigpond.com)
* ----------------------------------------------------------------------------

function IsArmstrongNumber(n)
   local i, digits, sumDTP := 0

   * Reject missing, or wrong number of arguments
   if PCOUNT() <> 1 ; return NIL ; endif

   * Reject non-numeric, or non-integer, values
   if VALTYPE(n) <> "N" ; return NIL ; endif
   if AT(".", STR(n)) <> 0 ; return NIL ; endif

   * Weed out obvious non-computational candidates
   if n < 0 ; return .F. ; endif
   if n < 10 ; return .T. ; endif
   if n < 100 ; return .F. ; endif

   * Convert input argument to string to determine number of digits, and
   *  to facilitate digit extraction
   n := ALLTRIM(STR(n)) ; digits := LEN(n)
   for i := 1 to digits
      sumDTP += VAL(SUBSTR(n, i, 1)) ** digits
   next

return sumDTP == VAL(n)

