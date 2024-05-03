* ----------------------------------------------------------------------------
* exercism.org
* Harbour Track Exercise: error-handling
* Contributed: Anthony J. Borla (ajborla@bigpond.com)
* ----------------------------------------------------------------------------

function HandleError(name)
   * Reject missing, or wrong number of arguments
   if PCOUNT() <> 1 ; return NIL ; endif

* Perform expected processing
return "Hello, " + name

