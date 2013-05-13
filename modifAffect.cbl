       program-id. modifAffect.

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
       *>booleens
       1 pic x value 'n'.
       88 fin-lire value 'o' false 'n'.
       1 pic x value 'n'.
       88 trouve value 'o' false 'n'.


       1 suivant pic x.
       1 numSaisi pic 9(4) value 0.

       1 busSaisi pic 9(4).
       1 date1 pic 9(8).
       1 date2 pic 9(8).


       screen section.
       1 a-plg-next.
           2 line 24 'Appuyez sur une touche pour continuer' .
           2 s-next line 25 col 80 pic x to suivant auto secure.

       1 s-a-modifier.
           2 line 7 col 10 'Num'&x'82'&'ro d''affectation'.
           2 line 7 col 30 ' '&x'85'&' modifier : '.
           2 s-num line 8 col 10 pic 9(4) to numSaisi required.

       1 s-plg-saisie.
           2 line 10 col 10 'Num'&x'82'&'ro du bus : '.
           2 s-bus pic 9(4) to busSaisi.
           2 line 12 col 5 'Dates (au format AAAA/MM/JJ) : '.
           2 line 13 col 10 'd'&x'82'&'but d''affectation : '.
           2 s-date11 line 13 col 32 pic 9(4) to date1(1:4).
           2 '/'.
           2 s-date12 pic 9(2) to date1(5:2).
           2 '/'.
           2 s-date13 pic 9(2) to date1(7:2).
           2 line 14 col 10 'fin d''affectation : '.
           2 s-date21 line 14 col 30 pic 9(4) to date2(1:4).
           2 '/'.
           2 s-date22 pic 9(2) to date2(5:2).
           2 '/'.
           2 s-date23 pic 9(2) to date2(7:2).

       1 a-plg-res.
           2 line 20 col 15 'Affectation modifi'&x'82'&'e !'.

       1 a-plg-nonRes.
           2 line 19 col 15 'Echec. '.
           2 line 20 col 15 'Le num'&x'82'&'ro est peut-etre incorrect'.

       procedure division.
           display s-a-modifier
           accept s-num
           open i-o f-affectation
           read f-affectation next
           perform test after until trouve or fin-lire

               *> recherche numero affectation
           if Numaffect = numSaisi then
               set trouve to true
               set fin-lire to true
           else
               read f-affectation next
               end set fin-lire to true end-read
           end-if
           end-perform

           *> si on trouve le numero
            if trouve then
               display s-plg-saisie
               accept s-bus
               accept s-date11
               accept s-date12
               accept s-date13
               accept s-date21
               accept s-date22
               accept s-date23

               move busSaisi to numbusA
               move date1 to dateDebAffectA
               move date2 to dateFinAffectA

               rewrite Affectation
                   *> sinon
                   invalid key
                   display a-plg-nonRes
                   display a-plg-next
                   accept s-next

                   *> affichage modif OK
                   not invalid key
                   display a-plg-res
                   display a-plg-next
                   accept s-next

               end-rewrite
           else
               display a-plg-nonRes
               display a-plg-next
               accept s-next


           end-if
           set fin-lire to false
           set trouve to false

           close f-affectation
           goback.

       end program modifAffect.
