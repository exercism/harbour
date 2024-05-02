* ----------------------------------------------------------------------------
* exercism.org
* Harbour Track Exercise: acronym
* Contributed: Anthony J. Borla (ajborla@bigpond.com)
* ----------------------------------------------------------------------------

function Abbreviate(string)
   local i, words, acronym := ""

   * Reject missing, or wrong number of arguments
   if PCOUNT() <> 1 ; return NIL ; endif

   * Sanitize input string
   string := RemoveCharSet("_,*'"+CHR(34), string)
   string := STRTRAN(string, "-", " ")

   * Split string into array of words
   words := SToArr(string, " ")

   * Traverse array, progressively building acronym string
   for i := 1 to LEN(words)
      acronym += UPPER(SUBSTR(words[i], 1, 1))
   next
return acronym

#include "utils.prg"

