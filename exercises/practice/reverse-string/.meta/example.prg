* ----------------------------------------------------------------------------
* exercism.org
* Harbour Track Exercise: reverse-string
* Contributed: Anthony J. Borla (ajborla@bigpond.com)
* ----------------------------------------------------------------------------

function ReverseString(string)
   local i, rstring := ""
   * Reject missing, or wrong number of arguments
   if PCOUNT() <> 1 ; return NIL ; endif

   * Build return string by traversing input string backwards (right-to-left)
   for i := LEN(string) to 1 step -1
      rstring := rstring + SUBSTR(string, i, 1)
   next
return rstring

