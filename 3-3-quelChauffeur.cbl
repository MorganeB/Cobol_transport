       program-id. 3-3quelChauffeur.

       file-control.
           *> fichiers à ouvrir
           select f-chaufNouv assign 'ChaufNouv.dat' organization
           indexed
           access dynamic record key numchaufN.

           select f-bus assign 'FBus.dat' organization
           indexed
           access dynamic record key numero.

           select f-affectation assign 'Affectation.dat' organization
           indexed access dynamic
               record key Numaffect
               alternate record key NumchaufA duplicates
               alternate record key NumbusA duplicates.


       file section.

       fd f-chaufNouv.
       1 ChaufNouv.
           2 numchaufN pic 9(4).
           2 nomN pic x(30).
           2 prenomN pic x(30).
           2 datepermisN pic 9(8).


       fd f-bus.
       1 bus.
           2 numero pic 9(4).
           2 marque pic x(20).
           2 nbplaces pic 9(3).
           2 modele pic x(20).
           2 kilom pic 9(6).


       fd f-affectation.
       1 Affectation.
           2 Numaffect pic 9(4).
           2 numchaufA pic 9(4).
           2 numbusA pic 9(4).
           2 dateDebAffectA pic 9(8).
           2 dateFinAffectA pic 9(8).


       working-storage section.

       1 i pic 99 value 13 .  *> indice de ligne
       1 cpt pic 99.
       1 nextPage pic x.

       *>booleens
       1 pic x value 'n'.
       88 fin-lire value 'o' false 'n'.

       1 pic x value 'n'.
       88 trouve value 'o' false 'n'.

       1 pic x value 'n'.
       88 juste value 'o' false 'n'.

       1 suivant pic x.
       1 dateSaisie pic 9(8).
       1 busSaisi pic 9(4).




       screen section.
       1 a-plg-effacerEcran.
           2 blank screen.

       1 a-plg-nextPage.
           2 line 24 'Appuyez sur une touche pour afficher la suite' .
           2 s-nextPage line 25 col 80 pic x to nextPage auto secure.

       1 a-plg-titre.
           2 blank screen.
           2 line 4 col 10 'Recherche d''un chauffeur'.

       1 s-plg-saisie.
           2 line 8 col 4 'Date (format AAAA/MM/JJ) '.
           2 s-date11 line 8 col 35 pic z(4) to dateSaisie(1:4).
           2 line 8 col 39 '/'.
           2 s-date12 line 8 col 40 pic 9(2) to dateSaisie(5:2).
           2 line 8 col 43 '/'.
           2 s-date13 line 8 col 44 pic 9(2) to dateSaisie(7:2).
           2 line 9 col 4 'Bus num'&x'82'&'ro : '.
           2 s-bus line 9 col 20 pic z(4) to busSaisi required.

       1 a-plg-res.
           2 line i col 10 'Chauffeur affect'&x'82'&' : '.
           2 a-chauffeur line i col 35 pic x(30) from nomN.

       1 a-plg-nonRes.
           2 line 15 col 15 'Pas de chauffeur'.

       1 a-plg-next.
           2 line 24 'Appuyez sur une touche pour continuer' .
           2 s-next line 25 col 80 pic x to suivant auto secure.

       1 a-plg-erreur.
           2 line 23 col 12 'Saisir une date correcte svp'.

       1 a-effacer.
           2 line 23 blank line.


       procedure division.
           display a-plg-titre
           display s-plg-saisie
           accept s-date11
           accept s-date12
           accept s-date13
           accept s-bus

           *> verification date saisie
           perform test after until juste
               if dateSaisie(5:2) > 12 or dateSaisie (7:2) > 31 then
               display a-plg-erreur
               display s-plg-saisie
               accept s-date11
               accept s-date12
               accept s-date13

               else
                   set juste to true
                   display a-effacer
               end-if
           end-perform

           *>ouvertures des fichiers
           open input f-affectation
           open input f-bus
           open input f-chaufNouv

           read f-bus next
           end set fin-lire to true end-read

           read f-chaufNouv next
           end set fin-lire to true end-read


           read f-affectation next
           perform test after until fin-lire
               if busSaisi = numBusA then
                   if dateSaisie >= dateDebAffectA or
                   dateSaisie <= dateFinAffectA  then
                       perform mod-affichage
                       set trouve to true
                       set fin-lire to true
                   else
                       read f-affectation next
                        read f-chaufNouv next

                   end-if

               else
                   read f-affectation next
                   end set fin-lire to true end-read

                   read f-chaufNouv next
                   end set fin-lire to true end-read
               end-if

          end-perform

          if not trouve then
               display a-plg-nonRes
           end-if

          display a-plg-next
          accept s-next
          set trouve to false
          set fin-lire to false

           close f-affectation
           close f-bus
           close f-chaufNouv

           goback.

       mod-affichage.
           display a-plg-res
           compute i = i + 1
           if(i > 20) then
               compute i = 13
               display a-plg-nextPage
               accept s-nextPage
               display a-plg-effacerEcran
               display a-plg-titre
               display a-plg-res
           end-if

       .


       end program 3-3quelChauffeur.





