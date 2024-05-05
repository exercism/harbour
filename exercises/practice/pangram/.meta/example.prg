* ----------------------------------------------------------------------------
* exercism.org
* Harbour Track Exercise: pangram
* Contributed: Anthony J. Borla (ajborla@bigpond.com)
* ----------------------------------------------------------------------------

function IsPangram(string)
   local i, slen, idx, counts[26]

   * Reject missing, or wrong number of arguments
   if PCOUNT() <> 1 ; return NIL ; endif

   * Sanitize input string, extract statistics
   string := LOWER(string) ; slen := LEN(string)

   * A string whose length is less than the number of letters in the English
   *  alphabet cannot be a pangram
   if slen < 26 ; return .F. ; endif

   * Perform letter frequency count
   AFILL(counts, 0)
   for i := 1 to slen
      idx := ASC(SUBSTR(string, i, 1)) - ASC("a") + 1
      * Ignore all except lowercase letters
      if idx < 1 .OR. idx > 26 ; loop ; endif
      counts[idx]++
   next

   * Bail if letter not used at least once
   for i := 1 to 26
      if counts[i] < 1 ; return .F. ; endif
   next

* We have a pangram
return .T.

#include "utils.prg"

