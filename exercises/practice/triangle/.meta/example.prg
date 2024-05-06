* ----------------------------------------------------------------------------
* exercism.org
* Harbour Track Exercise: triangle
* Contributed: Anthony J. Borla (ajborla@bigpond.com)
* ----------------------------------------------------------------------------

function IsEquilateral(A, B, C)
   if PCOUNT() == 3 .AND. IsNonDegenerate({A, B, C})
      return A == B .AND. A == C
   endif
return .F.

function IsIsosceles(A, B, C)
   if PCOUNT() == 3 .AND. IsNonDegenerate({A, B, C})
      return A == B .OR. A == C .OR. B == C
   endif
return .F.

function IsScalene(A, B, C)
   if PCOUNT() == 3 .AND. IsNonDegenerate({A, B, C})
      return A <> B .AND. A <> C .AND. B <> C
   endif
return .F.

function IsNonDegenerate(triangle)
   local i
   for i := 1 to LEN(triangle)
      if VALTYPE(triangle[i]) <> "N" ; return .F. ; endif
      if triangle[i] <= 0 ; return .F. ; endif
   next
   if triangle[1] + triangle[2] <= triangle[3] ; return .F. ; endif
   if triangle[3] + triangle[1] <= triangle[2] ; return .F. ; endif
   if triangle[2] + triangle[3] <= triangle[1] ; return .F. ; endif
return .T.

