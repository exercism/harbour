* ----------------------------------------------------------------------------
* exercism.org
* Harbour Track Exercise: rna-transcription
* Contributed: Anthony J. Borla (ajborla@bigpond.com)
* ----------------------------------------------------------------------------

function Transcribe(strand)
   local i, nucleotide, newStrand := "", slen := LEN(strand)

   * Traverse strand (note start index of 1)
   for i := 1 to slen
      * Extract nucleotide at current index, transcribe, append to new (RNA)
      *  strand. Note use of 'exit' keyword (equivalent of C's 'break')
      nucleotide := SUBSTR(strand, i, 1)

      switch nucleotide
         case "A" ; nucleotide := "U" ; exit
         case "C" ; nucleotide := "G" ; exit
         case "G" ; nucleotide := "C" ; exit
         case "T" ; nucleotide := "A" ; exit
         otherwise ; return NIL
      endswitch

      newStrand := newStrand + nucleotide
   next

return newStrand

