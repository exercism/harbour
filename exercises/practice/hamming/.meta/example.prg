* ----------------------------------------------------------------------------
* exercism.org
* Harbour Track Exercise: hamming
* Contributed: Anthony J. Borla (ajborla@bigpond.com)
* ----------------------------------------------------------------------------

function Distance(strand1, strand2)
   local i, distance := 0, slen

   * Reject missing, or wrong number of arguments
   if PCOUNT() <> 2 ; return NIL ; endif

   * Safe to determine length since we should have a string
   slen := LEN(strand1)

   * Empty strands are identical, so Hamming Distance is zero
   if EMPTY(strand1) .AND. EMPTY(strand2) ; return 0 ; endif

   * Reject unequal length strands
   if slen <> LEN(strand2) ; return NIL ; endif

   * Traverse strands (note start index of 1)
   for i := 1 to slen
      * Compute Hamming Distance for each nucleotide
      distance += ;
         IIF(SUBSTR(strand1, i, 1) == SUBSTR(strand2, i, 1), 0, 1)
   next

return distance

