* ----------------------------------------------------------------------------
* exercism.org
* Harbour Track Exercise: collatz-conjecture
* Contributed: Anthony J. Borla (ajborla@bigpond.com)
* ----------------------------------------------------------------------------

function Steps(n)
   * Reject missing, or wrong number of arguments
   if PCOUNT() <> 1 ; return NIL ; endif

   * Reject non-numeric, or non-positive integer, values
   if VALTYPE(n) <> "N" ; return NIL ; endif
   if AT(".", STR(n)) <> 0 ; return NIL ; endif
   if n < 1 ; return NIL ; endif

* Compute steps
return Steps_(n, 0)

function Steps_(n, steps)
   if n == 1 ; return steps ; endif
   if n % 2 == 0 ; return Steps_(INT(n / 2), steps + 1) ; endif
return Steps_(n * 3 + 1, steps + 1)

