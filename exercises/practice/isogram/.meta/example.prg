* ----------------------------------------------------------------------------
* exercism.org
* Harbour Track Exercise: isogram
* Contributed: Anthony J. Borla (ajborla@bigpond.com)
* ----------------------------------------------------------------------------

function IsIsogram(string)
   local i, slen, idx, counts[26]

   * Reject missing, or wrong number of arguments
   if PCOUNT() <> 1 ; return NIL ; endif

   * Sanitize input string, extract statistics
   string := LOWER(string) ; slen := LEN(string)

   * Perform letter frequency count
   AFILL(counts, 0)
   for i := 1 to slen
      idx := ASC(SUBSTR(string, i, 1)) - ASC("a") + 1
      * Ignore all except lowercase letters
      if idx < 1 .OR. idx > 26 ; loop ; endif
      counts[idx]++
   next

   * Bail if letter appears more than once
   for i := 1 to 26
      if counts[i] > 1 ; return .F. ; endif
   next

* We have an isogram
return .T.

