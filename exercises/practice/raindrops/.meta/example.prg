* ----------------------------------------------------------------------------
* exercism.org
* Harbour Track Exercise: raindrops
* Contributed: Anthony J. Borla (ajborla@bigpond.com)
* ----------------------------------------------------------------------------

function Sounds(n)
   local sounds := ""

   * Reject missing, or wrong number of arguments
   if PCOUNT() <> 1 ; return NIL ; endif

   * Reject non-numeric, or non-positive integer, values
   if VALTYPE(n) <> "N" ; return NIL ; endif
   if AT(".", STR(n)) <> 0 ; return NIL ; endif
   if n < 1 ; return NIL ; endif

   * Determine rain sounds
   sounds += IIF(n % 3 == 0, "Pling", "")
   sounds += IIF(n % 5 == 0, "Plang", "")
   sounds += IIF(n % 7 == 0, "Plong", "")

   if EMPTY(sounds) ; sounds := ALLTRIM(STR(n)) ; endif

return sounds

