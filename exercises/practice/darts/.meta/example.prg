* ----------------------------------------------------------------------------
* exercism.org
* Harbour Track Exercise: darts
* Contributed: Anthony J. Borla (ajborla@bigpond.com)
* ----------------------------------------------------------------------------

function Score(x, y)
   local radius := x * x + y * y
   if radius > 100 ; return 0 ; endif
   if radius > 25 ; return 1 ; endif
   if radius > 1 ; return 5 ; endif
return 10

