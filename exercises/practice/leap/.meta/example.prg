* ----------------------------------------------------------------------------
* exercism.org
* Harbour Track Exercise: leap
* Contributed: Anthony J. Borla (ajborla@bigpond.com)
* ----------------------------------------------------------------------------

function LeapYear(year)
return year % 4 == 0 .AND. (year % 100 != 0 .OR. year % 400 == 0)

