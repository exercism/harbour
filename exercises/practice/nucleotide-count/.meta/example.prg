* ----------------------------------------------------------------------------
* exercism.org
* Harbour Track Exercise: nucleotide-count
* Contributed: Anthony J. Borla (ajborla@bigpond.com)
* ----------------------------------------------------------------------------

function Counts(strand)
   local i, nucleotide, slen := LEN(strand), ;
         count_A := 0, count_C := 0, count_G := 0, count_T := 0

   * Traverse strand (note start index of 1)
   for i := 1 to slen
      * Extract nucleotide at current index
      nucleotide := SUBSTR(strand, i, 1)

      * Bail on invalid nucleotide, or increment its frequency count
      switch nucleotide
         case "A" ; count_A++ ; exit
         case "C" ; count_C++ ; exit
         case "G" ; count_G++ ; exit
         case "T" ; count_T++ ; exit
         otherwise ; return NIL
      endswitch
   next

* Formatted frequency counts
return "A: " + ALLTRIM(STR(count_A)) + ;
       " C: " + ALLTRIM(STR(count_C)) + ;
       " G: " + ALLTRIM(STR(count_G)) + ;
       " T: " + ALLTRIM(STR(count_T))

