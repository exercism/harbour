* ----------------------------------------------------------------------------
* exercism.org
* Harbour Track Exercise: difference-of-squares
* Contributed: Anthony J. Borla (ajborla@bigpond.com)
* ----------------------------------------------------------------------------

function SumOfSquares(n)
   if PCOUNT() == 1 .AND. IsInteger(n) .AND. n > 0
      return ROUND(n * (n + 1) * (2 * n + 1) / 6, 0)
   endif
return NIL

function SquareOfSum(n)
   if PCOUNT() == 1 .AND. IsInteger(n) .AND. n > 0
      return ROUND((n * (n + 1) / 2) ** 2, 0)
   endif
return NIL

function Difference(n)
   if PCOUNT() == 1 .AND. IsInteger(n) .AND. n > 0
      return SquareOfSum(n) - SumOfSquares(n)
   endif
return NIL

function IsInteger(n)
   * Reject non-numeric, or non-integer, values
   if VALTYPE(n) <> "N" ; return .F. ; endif
   if AT(".", STR(n)) <> 0 ; return .F. ; endif
return .T.

