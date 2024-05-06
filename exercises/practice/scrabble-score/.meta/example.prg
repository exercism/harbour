* ----------------------------------------------------------------------------
* exercism.org
* Harbour Track Exercise: scrabble-score
* Contributed: Anthony J. Borla (ajborla@bigpond.com)
* ----------------------------------------------------------------------------

function Score(word)
   local i, letter, slen, score := 0

   * Reject missing, or wrong number of arguments
   if PCOUNT() <> 1 ; return NIL ; endif

   * Standardize word letters
   word := UPPER(word) ; slen := LEN(word)

   * Traverse word (note start index of 1)
   for i := 1 to slen
      * Extract letter at current index
      letter := SUBSTR(word, i, 1)

      * Score the letter
      if letter $ "AEIOULNRST" ; score += 1 ; loop ; endif
      if letter $ "DG" ; score += 2 ; loop ; endif
      if letter $ "BCMP" ; score += 3 ; loop ; endif
      if letter $ "FHVWY" ; score += 4 ; loop ; endif
      if letter $ "K" ; score += 5 ; loop ; endif
      if letter $ "JX" ; score += 8 ; loop ; endif
      if letter $ "QZ" ; score += 10 ; loop ; endif
   next

return score

