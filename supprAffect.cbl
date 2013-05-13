       program-id. supprAffect.

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
       1 suivant pic x.
       1 numSaisi pic 9(4) value 0.


       screen section.
       1 a-effacer.
           2 blank screen.

       1 a-plg-next.
           2 line 24 'Appuyez sur une touche pour continuer' .
           2 s-next line 25 col 80 pic x to suivant auto secure.

       1 s-plg-saisie.
           2 line 7 col 10 'Num'&x'82'&'ro d''affectation'.
           2 line 7 col 30 ' '&x'85'&' supprimer : '.
           2 s-num line 8 col 10 pic 9(4) to numSaisi required.

       1 a-plg-res.
           2 line 20 col 15 'Affectation supprim'&x'82'&'e !'.

       1 a-plg-nonRes.
           2 line 19 col 15 'Echec. '.
           2 line 20 col 15 'Le numero est peut-etre incorrect'.


       procedure division.
           display s-plg-saisie
           accept s-num
           open i-o f-affectation
           read f-affectation

           move numSaisi to Numaffect
           delete f-affectation
               invalid key
                   display a-plg-nonRes
               not invalid key
                   display a-plg-res
           end-delete

           display a-plg-next
           accept s-next

           close f-affectation
           goback.




       end program supprAffect.
