       program-id. ajoutAffect.

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
       1 newAffect pic 9(4) value 0.
       1 busSaisi pic 9(4).
       1 chauffeurSaisi pic 9(4).
       1 date1 pic 9(8).
       1 date2 pic 9(8).
       1 pic x value 'n'.
       88 fin-lire value 'o' false 'n'.

       1 suivant pic x.

       1 pic x value 'n'.
       88 juste value 'o' false 'n'.

       1 pic x value 'n'.
       88 juste2 value 'o' false 'n'.

       screen section.
       1 a-effacer.
           2 line 23 blank line.

       1 a-plg-next.
           2 line 24 'Appuyez sur une touche pour continuer' .
           2 s-next line 25 col 80 pic x to suivant auto secure.

       1 a-plg-erreur.
           2 line 23 col 12 'Saisir une date correcte svp'.

       1 a-plg-nonRes.
           2 line 14 'Echec'.

       1 s-plg-saisie.
           2 line 7 col 10 'Num'&x'82'&'ro du bus : '.
           2 s-bus pic z(4) to busSaisi.
           2 line 9 col 10  'Num'&x'82'&'ro du chauffeur : '.
           2 s-chauff pic z(4) to chauffeurSaisi required.

       1 s-plg-saisieDates.
           2 line 11 col 5 'Dates (au format AAAA/MM/JJ) : '.
           2 line 12 col 10 'd'&x'82'&'but d''affectation : '.
           2 s-date11 pic 9(4) to date1(1:4).
           2 '/'.
           2 s-date12 pic 9(2) to date1(5:2).
           2 '/'.
           2 s-date13 pic 9(2) to date1(7:2).
           2 line 13 col 10 'fin d''affectation : '.
           2 s-date21 pic 9(4) to date2(1:4).
           2 '/'.
           2 s-date22 pic 9(2) to date2(5:2).
           2 '/'.
           2 s-date23 pic 9(2) to date2(7:2).

       1 a-plg-res.
           2 line 16 col 15 'Affectation ajout'&x'82'&'e !'.
           2 line 17 col 15 'Numero affection : '.
           2 a-newAff pic z(4) from numaffect.

       procedure division.

           display s-plg-saisie
           accept s-bus
           accept s-chauff
           display s-plg-saisieDates
           accept s-date11
           accept s-date12
           accept s-date13
           accept s-date21
           accept s-date22
           accept s-date23

           *> verification date saisie
           perform test after until juste
               if date1(5:2) > 12 or date1(7:2) > 31 or date2(5:2) > 12
               or date2(7:2) > 31 then
               display a-plg-erreur
               display s-plg-saisieDates
               accept s-date11
               accept s-date12
               accept s-date13
               accept s-date21
               accept s-date22
               accept s-date23
               else
                   set juste to true
                   display a-effacer
               end-if
           end-perform


           open i-o f-affectation
               read f-affectation next
               end set fin-lire to true end-read
           perform test after until fin-lire
               if Numaffect > newAffect then
                   move Numaffect to newAffect
               end-if

           read f-affectation next
               end set fin-lire to true end-read
           end-perform

           if fin-lire then
               compute newAffect = newAffect + 1
               move newAffect to NumAffect
               move chauffeurSaisi to numChaufA
               move busSaisi to numbusA
               move date1 to dateDebAffectA
               move date2 to dateFinAffectA

               write Affectation
                   invalid key
                       display a-plg-nonRes
                   not invalid key
                       display a-plg-res
               end-write

               display a-plg-next
               accept s-next

               end-if

               close f-affectation
               goback.





       end program ajoutAffect.
