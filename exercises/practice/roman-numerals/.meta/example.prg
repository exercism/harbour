* ----------------------------------------------------------------------------
* exercism.org
* Harbour Track Exercise: roman-numerals
* Contributed: Anthony J. Borla (ajborla@bigpond.com)
* ----------------------------------------------------------------------------

function Roman(n)
   local digits, M, C, X, I

   * Reject missing, or wrong number of arguments
   if PCOUNT() <> 1 ; return NIL ; endif

   * Reject non-numeric, or non-integer, values
   if VALTYPE(n) <> "N" ; return NIL ; endif
   if AT(".", STR(n)) <> 0 ; return NIL ; endif

   * Reject out-of-range value
   if n < 1 .OR. n > 3999 ; return NIL ; endif

   * Extract 4 rightmost digits from zero-padded digit string
   digits := SToArr(RIGHT("000" + LTRIM(STR(n)), 4))

   * Map digits to Roman numeral values
   M := SToArr(".;M;MM;MMM", ";")[VAL(digits[1])+1]
   C := SToArr(".;C;CC;CCC;CD;D;DC;DCC;DCCC;CM", ";")[VAL(digits[2])+1]
   X := SToArr(".;X;XX;XXX;XL;L;LX;LXX;LXXX;XC", ";")[VAL(digits[3])+1]
   I := SToArr(".;I;II;III;IV;V;VI;VII;VIII;IX", ";")[VAL(digits[4])+1]

* Concatenate only non-zero positional values
return STRTRAN(M + C + X + I, ".")

#include "utils.prg"

