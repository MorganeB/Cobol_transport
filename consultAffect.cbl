       program-id. consultAffect.

       file-control.

       select f-affectation assign 'Affectation.dat' organization
       indexed access dynamic
       record key Numaffect
       alternate record key NumchaufA duplicates
       alternate record key NumbusA duplicates.


       file section.
       fd f-affectation.
       1 Affectation.
           2 Numaffect pic 9(4).
           2 numchaufA pic 9(4).
           2 numbusA pic 9(4).
           2 dateDebAffectA pic 9(8).
           2 dateFinAffectA pic 9(8).

       working-storage section.

       screen section.
       1 suivant pic x.

       1 a-plg-next.
           2 line 19 'Appuyez sur une touche pour continuer' .
           2 s-next line 25 col 80 pic x to suivant auto secure.


       1 a-plg-nonRes.
           2 line 14 'Affectation inexistante'.

       1 s-plg-matricule.
           2 line 8 col 11 'Num'&x'82'&'ro d''affectation : '.
           2 s-num line 8 col 40 pic zzzz to Numaffect
           required.

       1 a-plg-res.
           2 line 10 col 5 'Num'&x'82'&'ro chauffeur : '.
           2 a-num pic 9(4) from numchaufA.
           2 line 11 col 5 'Num'&x'82'&'ro du bus : '.
           2 a-bus pic 9(4) from numbusA.
           2 line 12 col 5 'Date de d'&x'82'&'but d''affection : '.
           2 a-date11 line 12 col 35 pic 9(4) from dateDebAffectA(1:4).
           2 '/'.
           2 a-date12 line 12 col 40 pic 9(2) from dateDebAffectA(5:2).
           2 '/'.
           2 a-date13 line 12 col 43 pic 9(2) from dateDebAffectA(7:2).
           2 line 13 col 5 'Date de fin d''affectation : '.
           2 a-date21 line 13 col 35 pic 9(4) from dateFinAffectA(1:4).
           2 '/'.
           2 a-date22 line 13 col 40 pic 9(2) from dateFinAffectA(5:2).
           2 '/'.
           2 a-date23 line 13 col 43 pic 9(2) from dateFinAffectA(7:2).


       procedure division.

           display s-plg-matricule
           accept s-num
           open input f-affectation
               read f-affectation
               invalid key
                   display a-plg-nonRes
                   display a-plg-next
                   accept s-next
               not invalid key
                   display a-plg-res
                   display a-plg-next
                   accept s-next

               end-read
           close f-affectation
           goback.


       end program consultAffect.

