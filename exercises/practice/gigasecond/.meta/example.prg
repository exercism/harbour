* ----------------------------------------------------------------------------
* exercism.org
* Harbour Track Exercise: gigasecond
* Contributed: Anthony J. Borla (ajborla@bigpond.com)
* ----------------------------------------------------------------------------

function From(datetime)
   local baseseconds := ISO8601ToSeconds(datetime)
return ;
   IIF(baseseconds == NIL, ;
      NIL, ;
      SecondsToISO8601(baseseconds + 1000000000))

*
* Utilities from DATETIME.PRG library
*

*
* Given an integer year date component, returns its status as a
*  leap year as a Boolean value.
*
function IsLeapYear(year) ; return ;
   year % 400 == 0 .OR. (year % 4 == 0 .AND. year % 100 != 0)

*
* Given a date string in ISO8601 format, YYYY-MM-DDTHH:MM:SS, returns
*  the individual date components as an array of integer values, in
*  the order: year, month, day, hour, minute, second.
*
function ISO8601ToYMDHMS(datetime)
   local dtlen, year, month, day, hour, minute, second

   * Ensure we have a (likely) ISO8601 formatted date string
   if PCOUNT() <> 1 .OR. VALTYPE(datetime) <> "C" ; return NIL ; endif
   dtlen := LEN(datetime)
   if dtlen <> 10 .AND. dtlen <> 19 ; return NIL ; endif

   * Extract components, return as array
   * Date components always exist
   if AT("-", datetime) == 5 .AND. RAT("-", datetime) == 8
      year := SUBSTR(datetime, 1, 4)
      month := SUBSTR(datetime, 6, 2)
      day := SUBSTR(datetime, 9, 2)
      * Ensure each component is a valid integer (no range check performed)
      if !(IsINTString(year)) ; return NIL ; endif
      if !(IsINTString(month)) ; return NIL ; endif
      if !(IsINTString(day)) ; return NIL ; endif
   else
      return NIL
   endif

   * Time components are optional - assume zero values if not included
   if AT("T", datetime) == 11
      if AT(":", datetime) == 14 .AND. RAT(":", datetime) == 17
         hour := SUBSTR(datetime, 12, 2)
         minute := SUBSTR(datetime, 15, 2)
         second := SUBSTR(datetime, 18, 2)
         * Ensure each component is a valid integer (no range check performed)
         if !(IsINTString(hour)) ; return NIL ; endif
         if !(IsINTString(minute)) ; return NIL ; endif
         if !(IsINTString(second)) ; return NIL ; endif
      else
         return NIL
      endif
   else
      hour := "00"
      minute := "00"
      second := "00"
   endif

return { year, month, day, hour, minute, second }

*
* Given an array of integer values, representing date components,
*  in the order: year, month, day, hour, minute, second, returns
*  a date string in ISO8601 format, YYYY-MM-DDTHH:MM:SS.
*
function YMDHMSToISO8601(ymdhms)
   local year, month, day, hour, minute, second
   local iso8601

   * Ensure we have an array, and of the correct size
   if PCOUNT() <> 1 .OR. VALTYPE(ymdhms) <> "A" ; return NIL ; endif
   if LEN(ymdhms) <> 6 ; return NIL ; endif

   * Extract date components, ensure each is a trimmed string
   year := IIF(VALTYPE(ymdhms[1]) == "N", ALLTRIM(STR(ymdhms[1])), ALLTRIM(ymdhms[1]))
   month := IIF(VALTYPE(ymdhms[2]) == "N", RIGHT("0"+LTRIM(STR(ymdhms[2])),2), ALLTRIM(ymdhms[2]))
   day := IIF(VALTYPE(ymdhms[3]) == "N", RIGHT("0"+LTRIM(STR(ymdhms[3])),2), ALLTRIM(ymdhms[3]))
   hour := IIF(VALTYPE(ymdhms[4]) == "N", RIGHT("0"+LTRIM(STR(ymdhms[4])),2), ALLTRIM(ymdhms[4]))
   minute := IIF(VALTYPE(ymdhms[5]) == "N", RIGHT("0"+LTRIM(STR(ymdhms[5])),2), ALLTRIM(ymdhms[5]))
   second := IIF(VALTYPE(ymdhms[6]) == "N", RIGHT("0"+LTRIM(STR(ymdhms[6])),2), ALLTRIM(ymdhms[6]))

   * Ensure each component is a valid integer (no range check performed)
   if !(IsINTString(year)) ; return NIL ; endif
   if !(IsINTString(month)) ; return NIL ; endif
   if !(IsINTString(day)) ; return NIL ; endif
   if !(IsINTString(hour)) ; return NIL ; endif
   if !(IsINTString(minute)) ; return NIL ; endif
   if !(IsINTString(second)) ; return NIL ; endif

   * Build, and return, the date string
   iso8601 := year + "-" + month + "-" + day + "T" + ;
              hour + ":" + minute + ":" + second

return iso8601

*
* Given an array of integer values, representing date components,
*  in the order: year, month, day, hour, minute, second, returns
*  an integer representing seconds before/after the Jan 1, 1970 epoch
*  date.
*
function YMDHMSToSeconds(ymdhms)
   local year, month, day, hour, minute, second, seconds
   local datecmd, datestr, datefile := "YMDHMS_TO_SECONDS.TXT"

   * Ensure we have an array, and of the correct size
   if PCOUNT() <> 1 .OR. VALTYPE(ymdhms) <> "A" ; return NIL ; endif
   if LEN(ymdhms) <> 6 ; return NIL ; endif

   * Extract date components, ensure each is a trimmed string
   year := IIF(VALTYPE(ymdhms[1]) == "N", ALLTRIM(STR(ymdhms[1])), ALLTRIM(ymdhms[1]))
   month := IIF(VALTYPE(ymdhms[2]) == "N", RIGHT("0"+LTRIM(STR(ymdhms[2])),2), ALLTRIM(ymdhms[2]))
   day := IIF(VALTYPE(ymdhms[3]) == "N", RIGHT("0"+LTRIM(STR(ymdhms[3])),2), ALLTRIM(ymdhms[3]))
   hour := IIF(VALTYPE(ymdhms[4]) == "N", RIGHT("0"+LTRIM(STR(ymdhms[4])),2), ALLTRIM(ymdhms[4]))
   minute := IIF(VALTYPE(ymdhms[5]) == "N", RIGHT("0"+LTRIM(STR(ymdhms[5])),2), ALLTRIM(ymdhms[5]))
   second := IIF(VALTYPE(ymdhms[6]) == "N", RIGHT("0"+LTRIM(STR(ymdhms[6])),2), ALLTRIM(ymdhms[6]))

   * Ensure each component is a valid integer (no range check performed)
   if !(IsINTString(year)) ; return NIL ; endif
   if !(IsINTString(month)) ; return NIL ; endif
   if !(IsINTString(day)) ; return NIL ; endif
   if !(IsINTString(hour)) ; return NIL ; endif
   if !(IsINTString(minute)) ; return NIL ; endif
   if !(IsINTString(second)) ; return NIL ; endif

   * Assemble date string for input to utility
   datestr := year + "-" + month + "-" + day + " " + ;
              hour + ":" + minute + ":" + second

   * Assemble `date` utility command string (*NIX-compatibility assumed)
   datecmd := "date -u -d " ;
              + CHR(39) + datestr + CHR(39) ;
              + " +" + CHR(39) + "%s" + CHR(39) ;
              + " > YMDHMS_TO_SECONDS.TXT"

   * Issue OS command, redirecting output to file
   __RUN(datecmd)

   * Read file contents into array for return, then cleanup file
   * Note LF needs to be stripped from file contents
   seconds := STRTRAN(MEMOREAD(datefile), CHR(10))
   ERASE &datefile

return VAL(seconds)

*
* Given a integer representing seconds before/after the Jan 1, 1970
*  epoch date, returns an array of its corresponding date components
*  in integer form, in order: year, month, day, hour, minute, second.
*
* Currently using OS functionality to perform task, but a native
*  solution is planned.
*
function SecondsToYMDHMS(seconds)
   local ymdHMS
   local datecmd, datefile := "SECONDS_TO_YMDHMS.TXT"

   * Ensure we have an integer value
   if PCOUNT() <> 1 .OR. VALTYPE(seconds) <> "N" ; return NIL ; endif

   * Assemble `date` utility command string (*NIX-compatibility assumed)
   datecmd := "date -u -d @" + ALLTRIM(STR(seconds)) + " +" ;
              + CHR(39) + "%Y;%m;%d;%H;%M;%S" + CHR(39) ;
              + " > SECONDS_TO_YMDHMS.TXT"

   * Issue OS command, redirecting output to file
   __RUN(datecmd)

   * Read file contents into array for return, then cleanup file
   * Note LF needs to be stripped from file contents
   ymdHMS := SToArr(STRTRAN(MEMOREAD(datefile), CHR(10)), ";")
   ERASE &datefile

return ymdHMS

*
* Given a date string in ISO8601 format, YYYY-MM-DDTHH:MM:SS, returns
*  an integer representing seconds before/after the Jan 1, 1970 epoch
*  date.
*
function ISO8601ToSeconds(datetime) ; return ;
   YMDHMSToSeconds(ISO8601ToYMDHMS(datetime))

*
* Given a integer representing seconds before/after the Jan 1, 1970
*  epoch date, returns the equivalent date as a date string in ISO8061
*  format: YYYY-MM-DDTHH:MM:SS.
*
function SecondsToISO8601(seconds) ; return ;
   YMDHMSToISO8601(SecondsToYMDHMS(seconds))

