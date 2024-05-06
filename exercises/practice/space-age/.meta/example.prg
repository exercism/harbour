* ----------------------------------------------------------------------------
* exercism.org
* Harbour Track Exercise: space-age
* Contributed: Anthony J. Borla (ajborla@bigpond.com)
* ----------------------------------------------------------------------------

function AgeYearsOn(planet, seconds)
   local age := 0, EARTH_YEAR_SECONDS := 31557600

   * Reject missing, or wrong number of arguments
   if PCOUNT() <> 2 ; return NIL ; endif

   * Check planet name
   switch planet
      case "mercury" ; exit
      case "venus" ; exit
      case "earth" ; exit
      case "mars" ; exit
      case "jupiter" ; exit
      case "saturn" ; exit
      case "uranus" ; exit
      case "neptune" ; exit
      otherwise ; return NIL
   endswitch

   * Reject non-numeric, or non-positive integer, seconds values
   if VALTYPE(seconds) <> "N" ; return NIL ; endif
   if AT(".", STR(seconds)) <> 0 ; return NIL ; endif
   if seconds < 1 ; return NIL ; endif

   * Check planet name
   switch planet
      case "mercury" ; age := seconds / (EARTH_YEAR_SECONDS * 0.2408467) ; exit
      case "venus" ; age := seconds / (EARTH_YEAR_SECONDS * 0.61519726) ; exit
      case "earth" ; age := seconds / (EARTH_YEAR_SECONDS * 1.0) ; exit
      case "mars" ; age := seconds / (EARTH_YEAR_SECONDS * 1.8808158) ; exit
      case "jupiter" ; age := seconds / (EARTH_YEAR_SECONDS * 11.862615) ; exit
      case "saturn" ; age := seconds / (EARTH_YEAR_SECONDS * 29.447498) ; exit
      case "uranus" ; age := seconds / (EARTH_YEAR_SECONDS * 84.016846) ; exit
      case "neptune" ; age := seconds / (EARTH_YEAR_SECONDS * 164.79132)
   endswitch

return ROUND(age, 2)

