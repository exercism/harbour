* ----------------------------------------------------------------------------
* exercism.org
* Harbour Track Exercise: two-fer
* Contributed: Anthony J. Borla (ajborla@bigpond.com)
* ----------------------------------------------------------------------------

function TwoFer(name)
return ;
   IIF(name == NIL .OR. EMPTY(name), ;
      "One for you, one for me.", ;
      "One for " + ALLTRIM(name) + ", one for me.")

